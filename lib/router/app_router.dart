// lib/router/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:pico_control/screens/bluetooth_off_screen.dart';
import 'package:pico_control/screens/device_screen.dart';
import 'package:pico_control/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ScanRoute.page, initial: true),
        AutoRoute(page: BluetoothOffRoute.page),
        AutoRoute(page: DeviceRoute.page),
      ];
}
