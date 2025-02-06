// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bluetoothDeviceNotifierHash() =>
    r'0fd28bf07c3f2343b25f03a16bd5ea8897c3177f';

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

abstract class _$BluetoothDeviceNotifier
    extends BuildlessAutoDisposeStreamNotifier<BluetoothConnectionState> {
  late final BluetoothDevice device;

  Stream<BluetoothConnectionState> build(
    BluetoothDevice device,
  );
}

/// See also [BluetoothDeviceNotifier].
@ProviderFor(BluetoothDeviceNotifier)
const bluetoothDeviceNotifierProvider = BluetoothDeviceNotifierFamily();

/// See also [BluetoothDeviceNotifier].
class BluetoothDeviceNotifierFamily
    extends Family<AsyncValue<BluetoothConnectionState>> {
  /// See also [BluetoothDeviceNotifier].
  const BluetoothDeviceNotifierFamily();

  /// See also [BluetoothDeviceNotifier].
  BluetoothDeviceNotifierProvider call(
    BluetoothDevice device,
  ) {
    return BluetoothDeviceNotifierProvider(
      device,
    );
  }

  @override
  BluetoothDeviceNotifierProvider getProviderOverride(
    covariant BluetoothDeviceNotifierProvider provider,
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
  String? get name => r'bluetoothDeviceNotifierProvider';
}

/// See also [BluetoothDeviceNotifier].
class BluetoothDeviceNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<BluetoothDeviceNotifier,
        BluetoothConnectionState> {
  /// See also [BluetoothDeviceNotifier].
  BluetoothDeviceNotifierProvider(
    BluetoothDevice device,
  ) : this._internal(
          () => BluetoothDeviceNotifier()..device = device,
          from: bluetoothDeviceNotifierProvider,
          name: r'bluetoothDeviceNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bluetoothDeviceNotifierHash,
          dependencies: BluetoothDeviceNotifierFamily._dependencies,
          allTransitiveDependencies:
              BluetoothDeviceNotifierFamily._allTransitiveDependencies,
          device: device,
        );

  BluetoothDeviceNotifierProvider._internal(
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
  Stream<BluetoothConnectionState> runNotifierBuild(
    covariant BluetoothDeviceNotifier notifier,
  ) {
    return notifier.build(
      device,
    );
  }

  @override
  Override overrideWith(BluetoothDeviceNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BluetoothDeviceNotifierProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<BluetoothDeviceNotifier,
      BluetoothConnectionState> createElement() {
    return _BluetoothDeviceNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BluetoothDeviceNotifierProvider && other.device == device;
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
mixin BluetoothDeviceNotifierRef
    on AutoDisposeStreamNotifierProviderRef<BluetoothConnectionState> {
  /// The parameter `device` of this provider.
  BluetoothDevice get device;
}

class _BluetoothDeviceNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<BluetoothDeviceNotifier,
        BluetoothConnectionState> with BluetoothDeviceNotifierRef {
  _BluetoothDeviceNotifierProviderElement(super.provider);

  @override
  BluetoothDevice get device =>
      (origin as BluetoothDeviceNotifierProvider).device;
}

String _$scanResultsNotifierHash() =>
    r'4e8f7380e12f3f4f58577ea9b4ad90b2038f8596';

/// See also [ScanResultsNotifier].
@ProviderFor(ScanResultsNotifier)
final scanResultsNotifierProvider = AutoDisposeStreamNotifierProvider<
    ScanResultsNotifier, List<ScanResult>>.internal(
  ScanResultsNotifier.new,
  name: r'scanResultsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scanResultsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScanResultsNotifier = AutoDisposeStreamNotifier<List<ScanResult>>;
String _$systemDevicesNotifierHash() =>
    r'04feb58465e510601809912f91c15903d477a722';

/// See also [SystemDevicesNotifier].
@ProviderFor(SystemDevicesNotifier)
final systemDevicesNotifierProvider = AutoDisposeAsyncNotifierProvider<
    SystemDevicesNotifier, List<BluetoothDevice>>.internal(
  SystemDevicesNotifier.new,
  name: r'systemDevicesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$systemDevicesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SystemDevicesNotifier
    = AutoDisposeAsyncNotifier<List<BluetoothDevice>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
