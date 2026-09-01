import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:multimedia_sticker_maker/data/models/remote/api_pagination_dto.dart';
import 'package:multimedia_sticker_maker/data/models/remote/api_sticker_dto.dart';
import 'package:multimedia_sticker_maker/data/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_sticker_provider.g.dart';

/// State for the Explore Stickers screen.
@immutable
class ExploreState {
  const ExploreState({
    this.stickers = const [],
    this.pagination,
    this.searchQuery = '',
    this.currentPage = 1,
    this.isLoading = false,
    this.error,
  });

  final List<ApiStickerDto> stickers;
  final ApiPaginationDto? pagination;
  final String searchQuery;
  final int currentPage;
  final bool isLoading;
  final String? error;

  bool get hasPreviousPage => currentPage > 1;
  bool get hasNextPage =>
      pagination != null && currentPage < pagination!.totalPages;

  ExploreState copyWith({
    List<ApiStickerDto>? stickers,
    ApiPaginationDto? pagination,
    String? searchQuery,
    int? currentPage,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return ExploreState(
      stickers: stickers ?? this.stickers,
      pagination: pagination ?? this.pagination,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Riverpod notifier that manages explore sticker state with
/// search (debounced) and Next/Previous pagination.
@riverpod
class ExploreStickers extends _$ExploreStickers {
  static const int _limit = 15;
  static const Duration _debounceDuration = Duration(milliseconds: 400);

  Timer? _debounceTimer;

  @override
  ExploreState build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    // Trigger initial load after first build.
    Future.microtask(() => _fetchPage(page: 1, search: ''));
    return const ExploreState(isLoading: true);
  }

  /// Triggered when the user types in the search bar.
  /// Resets to page 1 after the debounce period.
  void onSearchChanged(String query) {
    _debounceTimer?.cancel();
    state = state.copyWith(
      searchQuery: query,
      isLoading: true,
      clearError: true,
    );
    _debounceTimer = Timer(_debounceDuration, () {
      _fetchPage(page: 1, search: query);
    });
  }

  /// Navigate to the next page.
  Future<void> nextPage() async {
    if (!state.hasNextPage) return;
    await _fetchPage(page: state.currentPage + 1, search: state.searchQuery);
  }

  /// Navigate to the previous page.
  Future<void> previousPage() async {
    if (!state.hasPreviousPage) return;
    await _fetchPage(page: state.currentPage - 1, search: state.searchQuery);
  }

  /// Retry the current page after an error.
  Future<void> retry() async {
    await _fetchPage(page: state.currentPage, search: state.searchQuery);
  }

  Future<void> _fetchPage({required int page, required String search}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final useCase = await ref.read(stickerUseCaseProvider.future);
      final response = await useCase.searchStickers(
        search: search,
        page: page,
        limit: _limit,
      );
      state = state.copyWith(
        stickers: response.stickers,
        pagination: response.pagination,
        currentPage: response.pagination.page,
        isLoading: false,
      );
    } catch (e, st) {
      log(
        'ExploreStickers._fetchPage error: $e',
        stackTrace: st,
        name: 'ExploreStickers',
      );
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
