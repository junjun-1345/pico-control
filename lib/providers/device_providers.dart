// lib/providers/device_providers.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_providers.g.dart';

@riverpod
class CharacteristicNotifier extends _$CharacteristicNotifier {
  @override
  BluetoothCharacteristic? build() => null;

  void setCharacteristic(BluetoothCharacteristic characteristic) {
    state = characteristic;
  }
}

@riverpod
class PinStatesNotifier extends _$PinStatesNotifier {
  @override
  Map<String, dynamic> build() => {};

  void updatePinStates(Map<String, dynamic> newStates) {
    print('Pin states update: $newStates');
    state = newStates;
  }
}

@riverpod
class DeviceServiceNotifier extends _$DeviceServiceNotifier {
  static const String serviceUuid = '1234';
  static const String characteristicUuid = '5678';

  @override
  Future<BluetoothCharacteristic?> build(BluetoothDevice device) async {
    try {
      print('デバイス ${device.platformName} のサービス検索開始');

      // 接続状態を確認
      final connectionState = await device.connectionState.first;
      if (connectionState != BluetoothConnectionState.connected) {
        print('デバイスに接続中...');
        await device.connect();

        // 接続完了を待つ
        await device.connectionState
            .firstWhere((state) => state == BluetoothConnectionState.connected)
            .timeout(
              const Duration(seconds: 5),
              onTimeout: () => throw TimeoutException('接続タイムアウト'),
            );
      }

      print('サービスを検索中...');
      final services = await device.discoverServices();

      print('検出されたサービス一覧:');
      for (var service in services) {
        print('Service UUID: ${service.uuid}');
        for (var char in service.characteristics) {
          print('  Characteristic UUID: ${char.uuid}');
          print('  Properties: ${char.properties}');
        }
      }

      BluetoothService? foundService;
      for (var service in services) {
        if (service.uuid.toString().contains(serviceUuid)) {
          foundService = service;
          break;
        }
      }
      if (foundService == null) {
        print(
            '利用可能なサービス: ${services.map((s) => s.uuid.toString()).join(", ")}');
        throw Exception('サービスが見つかりません: $serviceUuid');
      }
      print('サービスを発見: ${foundService.uuid}');

      BluetoothCharacteristic? foundCharacteristic;
      for (var characteristic in foundService.characteristics) {
        if (characteristic.uuid.toString().contains(characteristicUuid)) {
          foundCharacteristic = characteristic;
          break;
        }
      }
      if (foundCharacteristic == null) {
        print(
            '利用可能なキャラクタリスティック: ${foundService.characteristics.map((c) => c.uuid.toString()).join(", ")}');
        throw Exception('キャラクタリスティックが見つかりません: $characteristicUuid');
      }
      print('キャラクタリスティックを発見: ${foundCharacteristic.uuid}');

      return foundCharacteristic;
    } catch (e, stack) {
      print('Service discovery error: $e');
      print('Stack trace: $stack');
      return null;
    }
  }

  Future<void> sendCommand(Map<String, dynamic> command) async {
    final characteristic = state.valueOrNull;
    if (characteristic == null) {
      print('Characteristic not available');
      return;
    }

    try {
      final data = utf8.encode(json.encode(command));
      print('送信コマンド: ${json.encode(command)}');
      await characteristic.write(data);
      print('コマンド送信完了');
    } catch (e) {
      print('Send command error: $e');
    }
  }

  Future<void> readPins() async {
    try {
      print('ピン状態の読み取りを要求');
      await sendCommand({'cmd': 'read'});
    } catch (e) {
      print('Read pins error: $e');
    }
  }
}
