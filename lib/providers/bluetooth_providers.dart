// lib/providers/bluetooth_providers.dart
import 'package:pico_control/utils/extra.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bluetooth_providers.g.dart';

@riverpod
class BluetoothDeviceNotifier extends _$BluetoothDeviceNotifier {
  @override
  Stream<BluetoothConnectionState> build(BluetoothDevice device) {
    return device.connectionState;
  }

  Future<void> connect() async {
    try {
      await device.connectAndUpdateStream();
    } catch (e) {
      // エラー処理
    }
  }

  Future<void> disconnect() async {
    try {
      await device.disconnectAndUpdateStream();
    } catch (e) {
      // エラー処理
    }
  }
}

@riverpod
class ScanResultsNotifier extends _$ScanResultsNotifier {
  @override
  Stream<List<ScanResult>> build() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      // エラー処理
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      // エラー処理
    }
  }
}

@riverpod
class SystemDevicesNotifier extends _$SystemDevicesNotifier {
  @override
  Future<List<BluetoothDevice>> build() async {
    try {
      return await FlutterBluePlus.systemDevices([Guid("180f")]);
    } catch (e) {
      return [];
    }
  }
}
