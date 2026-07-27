// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isar)
final isarProvider = IsarProvider._();

final class IsarProvider
    extends $FunctionalProvider<AsyncValue<Isar>, Isar, FutureOr<Isar>>
    with $FutureModifier<Isar>, $FutureProvider<Isar> {
  IsarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isarHash();

  @$internal
  @override
  $FutureProviderElement<Isar> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Isar> create(Ref ref) {
    return isar(ref);
  }
}

String _$isarHash() => r'd71fe5f2ac244c78f67f4ad708e15a5c98171281';

@ProviderFor(localDataSource)
final localDataSourceProvider = LocalDataSourceProvider._();

final class LocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalDataSource>,
          LocalDataSource,
          FutureOr<LocalDataSource>
        >
    with $FutureModifier<LocalDataSource>, $FutureProvider<LocalDataSource> {
  LocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<LocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalDataSource> create(Ref ref) {
    return localDataSource(ref);
  }
}

String _$localDataSourceHash() => r'6255125432db890baeb92f64e1ffc02f9ede0b2a';

@ProviderFor(stickerRepository)
final stickerRepositoryProvider = StickerRepositoryProvider._();

final class StickerRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<StickerRepository>,
          StickerRepository,
          FutureOr<StickerRepository>
        >
    with
        $FutureModifier<StickerRepository>,
        $FutureProvider<StickerRepository> {
  StickerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stickerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stickerRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<StickerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StickerRepository> create(Ref ref) {
    return stickerRepository(ref);
  }
}

String _$stickerRepositoryHash() => r'9f70102916e8eb1e65a517cd3307f5c547c34962';

@ProviderFor(stickerUseCase)
final stickerUseCaseProvider = StickerUseCaseProvider._();

final class StickerUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<StickerUseCase>,
          StickerUseCase,
          FutureOr<StickerUseCase>
        >
    with $FutureModifier<StickerUseCase>, $FutureProvider<StickerUseCase> {
  StickerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stickerUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stickerUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<StickerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StickerUseCase> create(Ref ref) {
    return stickerUseCase(ref);
  }
}

String _$stickerUseCaseHash() => r'414e79be47c9d41f673ad99891d2835fd14e68ea';
