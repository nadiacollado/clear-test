// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fakeAuthRepositoryProviderHash() =>
    r'5b7fe40a655979b589be9a756079777535d876fc';

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

abstract class _$FakeAuthRepositoryProvider
    extends BuildlessNotifier<FakeAuth> {
  late final AuthStatus authStatus;

  FakeAuth build(
    AuthStatus authStatus,
  );
}

/// See also [FakeAuthRepositoryProvider].
@ProviderFor(FakeAuthRepositoryProvider)
const fakeAuthRepositoryProviderProvider = FakeAuthRepositoryProviderFamily();

/// See also [FakeAuthRepositoryProvider].
class FakeAuthRepositoryProviderFamily extends Family<FakeAuth> {
  /// See also [FakeAuthRepositoryProvider].
  const FakeAuthRepositoryProviderFamily();

  /// See also [FakeAuthRepositoryProvider].
  FakeAuthRepositoryProviderProvider call(
    AuthStatus authStatus,
  ) {
    return FakeAuthRepositoryProviderProvider(
      authStatus,
    );
  }

  @override
  FakeAuthRepositoryProviderProvider getProviderOverride(
    covariant FakeAuthRepositoryProviderProvider provider,
  ) {
    return call(
      provider.authStatus,
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
  String? get name => r'fakeAuthRepositoryProviderProvider';
}

/// See also [FakeAuthRepositoryProvider].
class FakeAuthRepositoryProviderProvider
    extends NotifierProviderImpl<FakeAuthRepositoryProvider, FakeAuth> {
  /// See also [FakeAuthRepositoryProvider].
  FakeAuthRepositoryProviderProvider(
    AuthStatus authStatus,
  ) : this._internal(
          () => FakeAuthRepositoryProvider()..authStatus = authStatus,
          from: fakeAuthRepositoryProviderProvider,
          name: r'fakeAuthRepositoryProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fakeAuthRepositoryProviderHash,
          dependencies: FakeAuthRepositoryProviderFamily._dependencies,
          allTransitiveDependencies:
              FakeAuthRepositoryProviderFamily._allTransitiveDependencies,
          authStatus: authStatus,
        );

  FakeAuthRepositoryProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authStatus,
  }) : super.internal();

  final AuthStatus authStatus;

  @override
  FakeAuth runNotifierBuild(
    covariant FakeAuthRepositoryProvider notifier,
  ) {
    return notifier.build(
      authStatus,
    );
  }

  @override
  Override overrideWith(FakeAuthRepositoryProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: FakeAuthRepositoryProviderProvider._internal(
        () => create()..authStatus = authStatus,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authStatus: authStatus,
      ),
    );
  }

  @override
  NotifierProviderElement<FakeAuthRepositoryProvider, FakeAuth>
      createElement() {
    return _FakeAuthRepositoryProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FakeAuthRepositoryProviderProvider &&
        other.authStatus == authStatus;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authStatus.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FakeAuthRepositoryProviderRef on NotifierProviderRef<FakeAuth> {
  /// The parameter `authStatus` of this provider.
  AuthStatus get authStatus;
}

class _FakeAuthRepositoryProviderProviderElement
    extends NotifierProviderElement<FakeAuthRepositoryProvider, FakeAuth>
    with FakeAuthRepositoryProviderRef {
  _FakeAuthRepositoryProviderProviderElement(super.provider);

  @override
  AuthStatus get authStatus =>
      (origin as FakeAuthRepositoryProviderProvider).authStatus;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
