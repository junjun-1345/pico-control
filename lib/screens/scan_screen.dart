// lib/screens/scan_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:pico_control/router/app_router.dart';
import 'package:pico_control/utils/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/bluetooth_providers.dart';
import '../utils/snackbar.dart';
import '../widgets/scan_result_tile.dart';

@RoutePage()
class ScanScreen extends HookConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mounted = useRef(true);
    final isScanning = useRef(false);

    useEffect(() {
      return () {
        mounted.value = false;
      };
    }, const []);

    Future<void> onScanPressed() async {
      try {
        if (!mounted.value) return;
        isScanning.value = true;
        await ref.read(scanResultsNotifierProvider.notifier).startScan();
      } catch (e) {
        if (!mounted.value) return;
        Snackbar.show(
          ABC.b,
          prettyException("Start Scan Error:", e),
          success: false,
        );
      } finally {
        if (mounted.value) {
          isScanning.value = false;
        }
      }
    }

    void onConnectPressed(BluetoothDevice device) {
      if (!mounted.value) return;
      device.connectAndUpdateStream().catchError((e) {
        if (!mounted.value) return;
        Snackbar.show(
          ABC.c,
          prettyException("Connect Error:", e),
          success: false,
        );
      });

      context.router.push(DeviceRoute(device: device));
    }

    Future<void> onRefresh() async {
      if (!mounted.value) return;
      await onScanPressed();
      return Future.delayed(const Duration(milliseconds: 500));
    }

    // 監視を設定
    useEffect(() {
      if (!mounted.value) return null;

      return () {
        // クリーンアップ時に必要な処理
        if (mounted.value) {
          ref.read(scanResultsNotifierProvider.notifier).stopScan();
        }
      };
    }, const []);

    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyB,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Devices'),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ref.watch(scanResultsNotifierProvider).when(
                data: (results) => ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return ScanResultTile(
                      result: result,
                      onTap: () => onConnectPressed(result.device),
                    );
                  },
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onScanPressed,
          child: Icon(isScanning.value ? Icons.stop : Icons.search),
        ),
      ),
    );
  }
}
