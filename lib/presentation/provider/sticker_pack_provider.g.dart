// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_pack_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StickerPackProvider)
final stickerPackProviderProvider = StickerPackProviderProvider._();

final class StickerPackProviderProvider
    extends $AsyncNotifierProvider<StickerPackProvider, List<StickerPack>> {
  StickerPackProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stickerPackProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stickerPackProviderHash();

  @$internal
  @override
  StickerPackProvider create() => StickerPackProvider();
}

String _$stickerPackProviderHash() =>
    r'61071fa175318ccefae5abcc8795a55d17fc65c1';

abstract class _$StickerPackProvider extends $AsyncNotifier<List<StickerPack>> {
  FutureOr<List<StickerPack>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<StickerPack>>, List<StickerPack>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<StickerPack>>, List<StickerPack>>,
              AsyncValue<List<StickerPack>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
