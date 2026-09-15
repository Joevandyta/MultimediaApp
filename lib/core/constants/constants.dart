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


const stickersTemplate = {
  '01_Cuppy_smile.webp': ['☕', '🙂'],
  '02_Cuppy_lol.webp': ['😄', '😀'],
  '03_Cuppy_rofl.webp': ['😆', '😂'],
  '04_Cuppy_sad.webp': ['😃', '😍'],
  '05_Cuppy_cry.webp': ['😭', '💧'],
  '06_Cuppy_love.webp': ['😍', '♥'],
  '07_Cuppy_hate.webp': ['💔', '👎'],
  '08_Cuppy_lovewithmug.webp': ['😍', '💑'],
  '09_Cuppy_lovewithcookie.webp': ['😘', '🍪'],
  '10_Cuppy_hmm.webp': ['🤔', '😐'],
  '11_Cuppy_upset.webp': ['😱', '😵'],
  '12_Cuppy_angry.webp': ['😡', '😠'],
  '13_Cuppy_curious.webp': ['❓', '🤔'],
  '14_Cuppy_weird.webp': ['🌈', '😜'],
  '15_Cuppy_bluescreen.webp': ['💻', '😩'],
  '16_Cuppy_angry.webp': ['😡', '😤'],
  '17_Cuppy_tired.webp': ['😩', '😨'],
  '18_Cuppy_workhard.webp': ['😔', '😨'],
  '19_Cuppy_shine.webp': ['🎉', '✨'],
  '20_Cuppy_disgusting.webp': ['🤮', '👎'],
  '21_Cuppy_hi.webp': ['🖐', '🙋'],
  '22_Cuppy_bye.webp': ['🖐', '👋'],
};
