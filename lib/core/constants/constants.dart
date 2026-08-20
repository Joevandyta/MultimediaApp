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

  static const addSticker = '/addsticker';
  static const addStickerName = 'addSticker';
}
