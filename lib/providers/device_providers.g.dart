// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$characteristicNotifierHash() =>
    r'7aa30243973b9e0c13e4ee242e177f141bc1331c';

/// See also [CharacteristicNotifier].
@ProviderFor(CharacteristicNotifier)
final characteristicNotifierProvider = AutoDisposeNotifierProvider<
    CharacteristicNotifier, BluetoothCharacteristic?>.internal(
  CharacteristicNotifier.new,
  name: r'characteristicNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$characteristicNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CharacteristicNotifier
    = AutoDisposeNotifier<BluetoothCharacteristic?>;
String _$pinStatesNotifierHash() => r'b3426809f39dfbae50f78569af598690da51cb6b';

/// See also [PinStatesNotifier].
@ProviderFor(PinStatesNotifier)
final pinStatesNotifierProvider = AutoDisposeNotifierProvider<PinStatesNotifier,
    Map<String, dynamic>>.internal(
  PinStatesNotifier.new,
  name: r'pinStatesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pinStatesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PinStatesNotifier = AutoDisposeNotifier<Map<String, dynamic>>;
String _$deviceServiceNotifierHash() =>
    r'1b882c2f1635fa2fd87646c1e4d6e3e28adfc74c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DeviceServiceNotifier
    extends BuildlessAutoDisposeAsyncNotifier<BluetoothCharacteristic?> {
  late final BluetoothDevice device;

  FutureOr<BluetoothCharacteristic?> build(
    BluetoothDevice device,
  );
}

/// See also [DeviceServiceNotifier].
@ProviderFor(DeviceServiceNotifier)
const deviceServiceNotifierProvider = DeviceServiceNotifierFamily();

/// See also [DeviceServiceNotifier].
class DeviceServiceNotifierFamily
    extends Family<AsyncValue<BluetoothCharacteristic?>> {
  /// See also [DeviceServiceNotifier].
  const DeviceServiceNotifierFamily();

  /// See also [DeviceServiceNotifier].
  DeviceServiceNotifierProvider call(
    BluetoothDevice device,
  ) {
    return DeviceServiceNotifierProvider(
      device,
    );
  }

  @override
  DeviceServiceNotifierProvider getProviderOverride(
    covariant DeviceServiceNotifierProvider provider,
  ) {
    return call(
      provider.device,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deviceServiceNotifierProvider';
}

/// See also [DeviceServiceNotifier].
class DeviceServiceNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DeviceServiceNotifier,
        BluetoothCharacteristic?> {
  /// See also [DeviceServiceNotifier].
  DeviceServiceNotifierProvider(
    BluetoothDevice device,
  ) : this._internal(
          () => DeviceServiceNotifier()..device = device,
          from: deviceServiceNotifierProvider,
          name: r'deviceServiceNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deviceServiceNotifierHash,
          dependencies: DeviceServiceNotifierFamily._dependencies,
          allTransitiveDependencies:
              DeviceServiceNotifierFamily._allTransitiveDependencies,
          device: device,
        );

  DeviceServiceNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.device,
  }) : super.internal();

  final BluetoothDevice device;

  @override
  FutureOr<BluetoothCharacteristic?> runNotifierBuild(
    covariant DeviceServiceNotifier notifier,
  ) {
    return notifier.build(
      device,
    );
  }

  @override
  Override overrideWith(DeviceServiceNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeviceServiceNotifierProvider._internal(
        () => create()..device = device,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        device: device,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeviceServiceNotifier,
      BluetoothCharacteristic?> createElement() {
    return _DeviceServiceNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceServiceNotifierProvider && other.device == device;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, device.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeviceServiceNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<BluetoothCharacteristic?> {
  /// The parameter `device` of this provider.
  BluetoothDevice get device;
}

class _DeviceServiceNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeviceServiceNotifier,
        BluetoothCharacteristic?> with DeviceServiceNotifierRef {
  _DeviceServiceNotifierProviderElement(super.provider);

  @override
  BluetoothDevice get device =>
      (origin as DeviceServiceNotifierProvider).device;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
