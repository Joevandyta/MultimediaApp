// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedStickers)
final savedStickersProvider = SavedStickersProvider._();

final class SavedStickersProvider
    extends $AsyncNotifierProvider<SavedStickers, List<StickerModel>> {
  SavedStickersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedStickersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedStickersHash();

  @$internal
  @override
  SavedStickers create() => SavedStickers();
}

String _$savedStickersHash() => r'c93c1c9e1435be627eedfb687ef8a3f84171805b';

abstract class _$SavedStickers extends $AsyncNotifier<List<StickerModel>> {
  FutureOr<List<StickerModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<StickerModel>>, List<StickerModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<StickerModel>>, List<StickerModel>>,
              AsyncValue<List<StickerModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(isSaved)
final isSavedProvider = IsSavedFamily._();

final class IsSavedProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsSavedProvider._({
    required IsSavedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isSavedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isSavedHash();

  @override
  String toString() {
    return r'isSavedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return isSaved(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsSavedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isSavedHash() => r'1b72d2d632793d02d42a083c522d57ca4b93a9b8';

final class IsSavedFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  IsSavedFamily._()
    : super(
        retry: null,
        name: r'isSavedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsSavedProvider call(String savedStickerId) =>
      IsSavedProvider._(argument: savedStickerId, from: this);

  @override
  String toString() => r'isSavedProvider';
}
