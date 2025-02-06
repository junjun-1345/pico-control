// lib/screens/bluetooth_off_screen.dart
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/snackbar.dart';

@RoutePage()
class BluetoothOffScreen extends HookConsumerWidget {
  const BluetoothOffScreen({super.key, this.adapterState});

  final BluetoothAdapterState? adapterState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildBluetoothOffIcon() {
      return const Icon(
        Icons.bluetooth_disabled,
        size: 200.0,
        color: Colors.white54,
      );
    }

    Widget buildTitle() {
      String? state = adapterState?.toString().split(".").last;
      return Text(
        'Bluetooth Adapter is ${state != null ? state : 'not available'}',
        style: Theme.of(context)
            .primaryTextTheme
            .titleSmall
            ?.copyWith(color: Colors.white),
      );
    }

    Widget buildTurnOnButton() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          child: const Text('TURN ON'),
          onPressed: () async {
            try {
              if (!kIsWeb && Platform.isAndroid) {
                await FlutterBluePlus.turnOn();
              }
            } catch (e) {
              Snackbar.show(ABC.a, prettyException("Error Turning On:", e),
                  success: false);
            }
          },
        ),
      );
    }

    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildBluetoothOffIcon(),
              buildTitle(),
              if (!kIsWeb && Platform.isAndroid) buildTurnOnButton(),
            ],
          ),
        ),
      ),
    );
  }
}
