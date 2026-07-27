import 'package:go_router/go_router.dart';
import 'package:multimedia_sticker_maker/presentation/screen/home_screen.dart';
import '../../data/models/sticker_model.dart';
import '../../presentation/screen/settings_screen.dart';
import '../../presentation/screen/main_navigation.dart';
import '../../presentation/screen/sticker_editor_screen.dart';
import '../../presentation/screen/saved_stickers_screen.dart';
import '../../presentation/screen/saved_packs_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainNavigation()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/editor',
      builder: (context, state) {
        final sticker = state.extra as StickerModel?;
        return StickerEditorScreen(initialSticker: sticker);
      },
    ),
    GoRoute(
      path: '/saved/stickers',
      builder: (context, state) => const SavedStickersScreen(),
    ),
    GoRoute(
      path: '/saved/packs',
      builder: (context, state) => const SavedPacksScreen(),
    ),
  ],
);
