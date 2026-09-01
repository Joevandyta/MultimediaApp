// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_sticker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod notifier that manages explore sticker state with
/// search (debounced) and Next/Previous pagination.

@ProviderFor(ExploreStickers)
final exploreStickersProvider = ExploreStickersProvider._();

/// Riverpod notifier that manages explore sticker state with
/// search (debounced) and Next/Previous pagination.
final class ExploreStickersProvider
    extends $NotifierProvider<ExploreStickers, ExploreState> {
  /// Riverpod notifier that manages explore sticker state with
  /// search (debounced) and Next/Previous pagination.
  ExploreStickersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreStickersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreStickersHash();

  @$internal
  @override
  ExploreStickers create() => ExploreStickers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExploreState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExploreState>(value),
    );
  }
}

String _$exploreStickersHash() => r'64566ae4b9928205efc6f1e4d8d7bd306d2d1094';

/// Riverpod notifier that manages explore sticker state with
/// search (debounced) and Next/Previous pagination.

abstract class _$ExploreStickers extends $Notifier<ExploreState> {
  ExploreState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ExploreState, ExploreState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExploreState, ExploreState>,
              ExploreState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
