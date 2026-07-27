# Implementation Plan: Create New Sticker Pack

We will implement the ability to create new sticker packs directly from the sticker editor's bottom sheet modal using a dialog, saving them to local Isar storage, and dynamically updating the list of packs.

## Proposed Changes

### Provider

#### [MODIFY] [sticker_pack_provider.dart](file:///k:/Programing/FlutterApp/multimedia_sticker_maker/lib/presentation/provider/sticker_pack_provider.dart)
- Change `ref.watch(stickerUseCaseProvider.future)` to `ref.read(stickerUseCaseProvider.future)` inside the action method `saveStickerPack`.
- Add `ref.invalidateSelf()` after saving a pack to ensure Riverpod automatically notifies listeners and refreshes the sticker pack list.

### Sticker Editor Screen

#### [MODIFY] [sticker_editor_screen.dart](file:///k:/Programing/FlutterApp/multimedia_sticker_maker/lib/presentation/screen/sticker_editor_screen.dart)
- Import `package:multimedia_sticker_maker/presentation/provider/sticker_pack_provider.dart` and `package:multimedia_sticker_maker/data/models/sticker_pack.dart`.
- Update `_showStickerPackGrid` to use a `Consumer` builder to watch the `stickerPackProviderProvider`.
- Change `_buildPacksGrid` and `_buildPackCard` to render real `StickerPack` models and their tray images (using `Image.file(File(pack.trayImagePath))`).
- Bind the `onTap` of the "Create Sticker Pack" card to open a custom dialog (`_showCreatePackDialog`).
- Implement `_onCreateStickerPack` to read the current image bytes, save it as a tray image via `saveImageTray`, generate a unique identifier prefixed with the app name, create a `StickerPack`, and save it.

## Verification Plan

### Manual Verification
1. Open the Sticker Editor screen.
2. Tap the **Save** button to open the Sticker Pack selection bottom sheet.
3. Tap the **Create Sticker Pack** card.
4. Fill out the "Pack Name" and "Publisher" in the modal dialog, then click **Create**.
5. Verify that the bottom sheet updates instantly and shows the new sticker pack card with the current sticker image.
