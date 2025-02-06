// lib/providers/scan_providers.dart
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_providers.g.dart';

@riverpod
class ScanResultsNotifier extends _$ScanResultsNotifier {
  @override
  Stream<List<ScanResult>> build() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
      );
    } catch (e) {
      print('Scan error: $e');
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Stop scan error: $e');
    }
  }
}
