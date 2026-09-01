/// Remote API base URL for fetching stickers.
/// Set via --dart-define=API_ENDPOINT_GET_ALL_STICKER=<url> at build time,
/// or falls back to the production URL.
abstract class AppConstants {
  AppConstants._();

  static const stickerApiBaseUrl = String.fromEnvironment(
    'API_ENDPOINT_GET_ALL_STICKER',
    defaultValue: 'https://stickerify-web.vercel.app/api/stickers',
  );
}

abstract class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const homeName = 'home';

  static const settings = '/settings';
  static const settingsName = 'settings';

  static const packs = '/packs';
  static const packsName = 'packs';

  static const stickerEditor = '/packs/:packId/stickers/:stickerId';
  static const stickerEditorName = 'StickerEditor';

  /// Build a concrete sticker-editor path, e.g.:
  /// stickerEditorPath('42', 'abc-123') -> /packs/42/stickers/abc-123
  static String stickerEditorPath(String packId, String stickerId) =>
      '/packs/$packId/stickers/$stickerId';

  static const savedStickers = '/stickers';
  static const savedStickersName = 'savedStickers';

  static const exploreStickers = '/explore';
  static const exploreStickersName = 'exploreStickers';

  static const addSticker = '/addsticker';
  static const addStickerName = 'addSticker';
}
