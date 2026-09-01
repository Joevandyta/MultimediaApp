import 'package:go_router/go_router.dart';
import 'package:multimedia_sticker_maker/core/constants/constants.dart';
import 'package:multimedia_sticker_maker/presentation/screen/main_navigation.dart';
import 'package:multimedia_sticker_maker/presentation/screen/packs/packs_screen.dart';
import 'package:multimedia_sticker_maker/presentation/screen/setting/settings_screen.dart';
import 'package:multimedia_sticker_maker/presentation/screen/sticker/explore_stickers_screen.dart';
import 'package:multimedia_sticker_maker/presentation/screen/sticker/saved_stickers_screen.dart';
import 'package:multimedia_sticker_maker/presentation/screen/sticker/sticker_editor_screen.dart';
// import 'sticker_model.dart'; // uncomment if using StickerModel as optional extra

/// Centralized route paths & names.
/// Using constants avoids typos and makes refactors (renaming a path)
/// a one-line change instead of a find-and-replace across the app.

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true, // set to false in release builds if noisy
  // Centralized error UI instead of the default Flutter error screen.

  // errorBuilder: (context, state) => ErrorScreen(error: state.error),

  // Example auth guard skeleton — wire up to your actual auth state
  // (Riverpod/Bloc/Provider). Left as a no-op redirect by default.
  // redirect: (context, state) {
  //   final isLoggedIn = authState.isLoggedIn;
  //   final isAuthRoute = state.matchedLocation == '/sign-in';
  //   if (!isLoggedIn && !isAuthRoute) return '/sign-in';
  //   if (isLoggedIn && isAuthRoute) return AppRoutes.home;
  //   return null;
  // },
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.homeName,
      builder: (context, state) => const MainNavigation(),
      // If MainNavigation has a bottom nav bar switching between tabs,
      // consider replacing this with StatefulShellRoute.indexedStack so
      // each tab keeps its own scroll/state when switching. See note below.
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: AppRoutes.settingsName,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.stickerEditor,
      name: AppRoutes.stickerEditorName,
      builder: (context, state) {
        final packId = state.pathParameters['packId']!;
        final stickerId = state.pathParameters['stickerId']!;
        return StickerEditorScreen(packId: packId, stickerId: stickerId);
      },
    ),
    GoRoute(
      path: AppRoutes.savedStickers,
      name: AppRoutes.savedStickersName,
      builder: (context, state) => const SavedStickersScreen(),
    ),
    GoRoute(
      path: AppRoutes.exploreStickers,
      name: AppRoutes.exploreStickersName,
      builder: (context, state) => const ExploreStickersScreen(),
    ),
    GoRoute(
      path: AppRoutes.packs,
      name: AppRoutes.packsName,
      builder: (context, state) => const PacksScreen(),
    ),
    GoRoute(
      path: AppRoutes.addSticker,
      name: AppRoutes.addStickerName,
      builder: (context, state) => const StickerEditorScreen(),
    ),
  ],
);
