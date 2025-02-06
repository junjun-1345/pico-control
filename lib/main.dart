import 'package:pico_control/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  // FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(
    const ProviderScope(
      child: FlutterBlueApp(),
    ),
  );
}

class FlutterBlueApp extends HookConsumerWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.config(),
    );
  }
}
