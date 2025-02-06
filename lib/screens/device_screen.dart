// lib/screens/device_screen.dart
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:pico_control/providers/bluetooth_providers.dart';
import 'package:pico_control/utils/data_converter.dart';
import 'package:pico_control/utils/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/device_providers.dart';

@RoutePage()
class DeviceScreen extends HookConsumerWidget {
  const DeviceScreen({
    super.key,
    required this.device,
  });

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceService = ref.watch(deviceServiceNotifierProvider(device));
    final pinStates = ref.watch(pinStatesNotifierProvider);
    final connectionState = ref.watch(bluetoothDeviceNotifierProvider(device));

    // DeviceScreen内のuseEffect部分も修正
    useEffect(() {
      bool mounted = true;
      if (deviceService.valueOrNull != null) {
        print('Setting up BLE notifications');
        final characteristic = deviceService.valueOrNull!;

        Future<void> setup() async {
          if (!mounted) return;
          try {
            await characteristic.setNotifyValue(true);
            print('Notifications enabled');

            // 初期データを要求
            if (!mounted) return;
            await ref
                .read(deviceServiceNotifierProvider(device).notifier)
                .sendCommand({'cmd': 'read'});
          } catch (e) {
            print('Setup error: $e');
          }
        }

        setup();

        final subscription = characteristic.onValueReceived.listen(
          (value) {
            if (!mounted) return;
            print('データ受信: ${String.fromCharCodes(value)}');
            try {
              final String jsonStr = String.fromCharCodes(value);
              final rawData = json.decode(jsonStr);
              // 変換したデータを直接pinStatesに渡す
              final convertedData =
                  BLEDataConverter.convertShortToLongFormat(rawData);
              if (convertedData != null) {
                print('Converted data: $convertedData');
                if (!mounted) return;
                ref
                    .read(pinStatesNotifierProvider.notifier)
                    .updatePinStates(convertedData);
              }
            } catch (e) {
              print('Data parsing error: $e');
            }
          },
          onError: (e) => print('Notification error: $e'),
        );
        return () {
          mounted = false;
          print('Cleaning up BLE connection');
          subscription.cancel();
          characteristic.setNotifyValue(false);
        };
      }
      return () {
        mounted = false;
      };
    }, [deviceService.valueOrNull]);
    // Connect to device on screen load
    useEffect(() {
      device.connectAndUpdateStream();
      return () {
        device.disconnectAndUpdateStream();
      };
    }, const []);

    // デバイス切断時のハンドリングを追加
    useEffect(() {
      return () {
        device.disconnect().catchError((e) {
          print('Disconnect error: $e');
        });
      };
    }, const []);

    // 接続状態の監視
    useEffect(() {
      final subscription = device.connectionState.listen((state) {
        print('接続状態の変更: $state');
        if (state == BluetoothConnectionState.disconnected) {
          // 再接続を試みる
          device.connect().catchError((e) {
            print('Reconnect error: $e');
          });
        }
      });

      return subscription.cancel;
    }, const []);

    Future<void> setPin(String pin, int value) async {
      final command = BLEDataConverter.createCommand(
        'set',
        category: 'digital_outputs',
        pin: pin,
        val: value,
      );
      await ref
          .read(deviceServiceNotifierProvider(device).notifier)
          .sendCommand(command);
    }

    Future<void> readPins() async {
      final command = BLEDataConverter.createCommand('read');
      await ref
          .read(deviceServiceNotifierProvider(device).notifier)
          .sendCommand(command);
    }

    Widget buildConnectButton() {
      return connectionState.when(
        data: (state) {
          final isConnected = state == BluetoothConnectionState.connected;
          return TextButton(
            onPressed: isConnected
                ? () => device.disconnectAndUpdateStream()
                : () => device.connectAndUpdateStream(),
            child: Text(
              isConnected ? 'DISCONNECT' : 'CONNECT',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Icon(Icons.error),
      );
    }

    Widget buildPinControls() {
      if (connectionState.valueOrNull != BluetoothConnectionState.connected) {
        return const Center(child: Text('デバイスに接続してください'));
      }
      if (pinStates.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          // デジタル出力の制御
          if (pinStates["digital_outputs"] != null)
            _buildDigitalOutputs(pinStates["digital_outputs"] as Map, setPin),

          // デジタル入力の表示
          if (pinStates["digital_inputs"] != null)
            _buildDigitalInputs(pinStates["digital_inputs"] as Map),

          // アナログ入力の表示
          if (pinStates["analog_inputs"] != null)
            _buildAnalogInputs(pinStates["analog_inputs"] as Map),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: readPins,
              child: const Text('更新'),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPIO Control'),
        actions: [buildConnectButton()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              connectionState.when(
                data: (state) =>
                    Text('状態: ${state.toString().split('.').last}'),
                loading: () => const Text('Connecting...'),
                error: (_, __) => const Text('Connection Error'),
              ),
              const SizedBox(height: 16),
              buildPinControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDigitalOutputs(
      Map<dynamic, dynamic> outputs, Function(String, int) setPin) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('デジタル出力',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...(outputs.entries.toList()
                ..sort((a, b) =>
                    (a.value["gp"] as int).compareTo(b.value["gp"] as int)))
              .map((entry) => SwitchListTile(
                    title: Text('${entry.key} (GP${entry.value["gp"]})'),
                    value: (entry.value["value"] as int) == 1,
                    onChanged: (bool value) => setPin(entry.key, value ? 1 : 0),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildDigitalInputs(Map<dynamic, dynamic> inputs) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('デジタル入力',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...(inputs.entries.toList()
                ..sort((a, b) =>
                    (a.value["gp"] as int).compareTo(b.value["gp"] as int)))
              .map((entry) => ListTile(
                    title: Text('${entry.key} (GP${entry.value["gp"]})'),
                    trailing: Icon(
                      (entry.value["value"] as int) == 1
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: (entry.value["value"] as int) == 1
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildAnalogInputs(Map<dynamic, dynamic> inputs) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('アナログ入力',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...(inputs.entries.toList()
                ..sort((a, b) =>
                    (a.value["gp"] as int).compareTo(b.value["gp"] as int)))
              .map((entry) => ListTile(
                    title: Text('${entry.key} (GP${entry.value["gp"]})'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: (entry.value["value"] as num) / 65535,
                        ),
                        Text(
                          '値: ${entry.value["value"]} (${((entry.value["value"] as num) / 65535 * 100).toStringAsFixed(1)}%)',
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
