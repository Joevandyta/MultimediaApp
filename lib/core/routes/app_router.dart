import 'package:go_router/go_router.dart';
import '../../data/models/sticker_model.dart';
import '../../presentation/screen/home_screen.dart';
import '../../presentation/screen/sticker_editor_screen.dart';
import '../../presentation/screen/saved_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/editor',
      builder: (context, state) {
        final sticker = state.extra as StickerModel?;
        return StickerEditorScreen(initialSticker: sticker);
      },
    ),
    GoRoute(path: '/saved', builder: (context, state) => const SavedScreen()),
  ],
);
