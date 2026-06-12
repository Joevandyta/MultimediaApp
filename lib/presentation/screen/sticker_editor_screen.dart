import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:multimedia_sticker_maker/data/models/sticker_pack.dart';
import 'package:multimedia_sticker_maker/presentation/provider/sticker_provider.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:whatsapp_stickers_injector/exceptions.dart';
import '../../data/models/sticker_model.dart';
import '../widgets/picker_option.dart';
import '../widgets/share_bar.dart';
import '../widgets/image_preview_card.dart';
import '../widgets/delete_confirm_modal.dart';

enum _PendingAction { none, save, update, delete }

class StickerEditorScreen extends ConsumerStatefulWidget {
  final StickerModel? initialSticker;
  const StickerEditorScreen({super.key, this.initialSticker});
  @override
  ConsumerState<StickerEditorScreen> createState() =>
      _StickerEditorScreenState();
}

class _StickerEditorScreenState extends ConsumerState<StickerEditorScreen>
    with TickerProviderStateMixin {
  File? _selectedImages;
  final bool _isProcessing = false;
  bool _isSharing = false;
  String? _currentSavedStickerId;
  // StickerModel? _currentSticker;
  bool _toggleSaveActive = false;
  bool _isInitialStickerSaved = false;
  bool _anyChanges = false;
  _PendingAction _pendingAction = _PendingAction.none;
  Key _imageKey = UniqueKey();
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    if (widget.initialSticker != null) {
      _selectedImages = File(widget.initialSticker!.imagePath);
      _currentSavedStickerId = widget.initialSticker!.savedStickerId;
      // _currentSticker = widget.initialSticker;
      _toggleSaveActive = true;
      _isInitialStickerSaved = true;
      _slideController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) return;
        await _flushPendingAction();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0F0D),
        body: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF25D366).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              left: -80,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF128C7E).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 24, 0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'WA Sticker Maker',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Text(
                              'Buat stiker WhatsApp mu sendiri',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.45),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF25D366,
                            ).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(
                                0xFF25D366,
                              ).withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.sticky_note_2_rounded,
                            color: Color(0xFF25D366),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Image area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _selectedImages == null
                          ? _emptyImageCard()
                          : _buildImagesPreview(),
                    ),
                  ),

                  const SizedBox(height: 100), // space for FAB
                ],
              ),
            ),
          ],
        ),

        // Floating bottom share bar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _selectedImages != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _anyChanges && !_toggleSaveActive
                          ? Container(
                              key: const ValueKey('warning'),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF25D366,
                                ).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(
                                    0xFF25D366,
                                  ).withValues(alpha: 0.4),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: Color(0xFF25D366),
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Perubahan belum disimpan',
                                    style: TextStyle(
                                      color: Color(0xFF25D366),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('no_warning')),
                    ),
                    const SizedBox(height: 4),
                    ShareBar(
                      key: const ValueKey('share_bar'),
                      onShare: _shareAsSticker,
                      onSave: _toggleSaveSticker,
                      isSharing: _isSharing,
                      isSaving: false,
                      isSaved: _toggleSaveActive,
                    ),
                  ],
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        ),
      ),
    );
  }

  Future<void> _flushPendingAction() async {
    if (_selectedImages == null && _pendingAction != _PendingAction.delete)
      return;

    switch (_pendingAction) {
      case _PendingAction.save:
        final bytes = await _processStickerImage(_selectedImages!);
        if (bytes == null) return;
        final ext = _selectedImages!.path.split('.').last.toLowerCase();
        await ref
            .read(savedStickersProvider.notifier)
            .saveNewSticker(bytes, ext);

      case _PendingAction.update:
        if (_currentSavedStickerId == null) return;
        final bytes = await _processStickerImage(_selectedImages!);
        if (bytes == null) return;
        await ref
            .read(savedStickersProvider.notifier)
            .updateSticker(_currentSavedStickerId!, bytes);

      case _PendingAction.delete:
        if (_currentSavedStickerId != null) {
          await ref
              .read(savedStickersProvider.notifier)
              .removeSticker(_currentSavedStickerId!);
        }
        try {
          await _selectedImages?.delete();
        } catch (_) {}

      case _PendingAction.none:
        break;
    }
  }

  Widget _buildImagesPreview() {
    return ImagePreviewCard(
      key: _imageKey,
      image: _selectedImages!,
      slideAnimation: _slideAnimation,
      onReplace: _showPickerDialog,
      onDelete: _deleteImage,
      isProcessing: _isProcessing,
      onEditTap: () {
        if (_selectedImages != null) {
          _openEditor(_selectedImages!);
        }
      },
    );
  }

  Future _openEditor(File imageFile) async {
    if (!mounted) return;

    final String extension = imageFile.path.split('.').last.toLowerCase();
    final customStickers = <File>[];
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProImageEditor.file(
          imageFile,
          callbacks: ProImageEditorCallbacks(
            onImageEditingComplete: (Uint8List bytes) async {
              final tempDir = await getTemporaryDirectory();
              final editedFile = File(
                '${tempDir.path}/edited_${DateTime.now().millisecondsSinceEpoch}.$extension',
              );
              await editedFile.writeAsBytes(bytes);
              if (!mounted) return;
              Navigator.pop(context);
              // If user was about to delete but chose to edit instead, reset to update

              setState(() {
                _selectedImages = editedFile;
                _toggleSaveActive = false;
                _anyChanges = true;
                _imageKey = UniqueKey();
                // apply the pendingAction changes above
              });

              if (_pendingAction == _PendingAction.delete) {
                _pendingAction = _isInitialStickerSaved
                    ? _PendingAction.update
                    : _PendingAction.save;
              }
              // If already saved, mark for update
              if (_isInitialStickerSaved &&
                  _pendingAction == _PendingAction.none) {
                _pendingAction = _PendingAction.update;
              }
              _slideController.forward(from: 0);
              HapticFeedback.mediumImpact();
            },
          ),
          configs: ProImageEditorConfigs(
            theme: Theme.of(context),
            mainEditor: MainEditorConfigs(
              tools: [
                SubEditorMode.paint,
                SubEditorMode.text,
                SubEditorMode.cropRotate,
                SubEditorMode.tune,
                SubEditorMode.filter,
                SubEditorMode.blur,
                SubEditorMode.emoji,
                SubEditorMode.sticker,
              ],
            ),
            designMode: ImageEditorDesignMode.material,
            textEditor: TextEditorConfigs(
              showSelectFontStyleBottomBar: true,
              customTextStyles: [GoogleFonts.poppins(), GoogleFonts.anton()],
            ),
            stickerEditor: StickerEditorConfigs(
              builder: (setLayer, scrollController) {
                final defaultStickers = [
                  'images/jidan.png',
                  'images/ironman.jpg',
                ];
                return StatefulBuilder(
                  builder: (context, setStickerState) {
                    final allItems = [
                      ...customStickers.map((e) => ('file', e as dynamic)),
                      ...defaultStickers.map((e) => ('asset', e as dynamic)),
                    ];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                final file = await _pickImage(
                                  fromCamera: false,
                                );
                                if (file != null) {
                                  customStickers.add(file);
                                }
                                setStickerState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 8,
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: Color(0xFF25D366),
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Add Image',
                                      style: TextStyle(
                                        color: Color(0xFF25D366),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: GridView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                            itemCount: allItems.length,
                            itemBuilder: (context, index) {
                              final item = allItems[index];
                              final isAsset = item.$1 == 'asset';
                              final source = item.$2;

                              return GestureDetector(
                                onTap: () => setLayer(
                                  WidgetLayer(
                                    widget: isAsset
                                        ? Image.asset(
                                            source as String,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.file(
                                            source as File,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                child: isAsset
                                    ? Image.asset(
                                        source as String,
                                        fit: BoxFit.contain,
                                      )
                                    : Image.file(
                                        source as File,
                                        fit: BoxFit.contain,
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImage({required bool fromCamera}) async {
    List<Media> images = [];
    if (fromCamera) {
      final Media? media = await ImagePickers.openCamera(
        cameraMimeType: CameraMimeType.photo,
      );
      if (media != null) {
        images = [media];
      }
    } else {
      images = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showCamera: false,
      );
    }
    if (images.isNotEmpty && images.first.path != null) {
      return File(images.first.path!);
    }

    return null;
  }

  Future<Uint8List?> _processStickerImage(File file) async {
    final Uint8List originalBytes = await file.readAsBytes();
    final img.Image? decoded = img.decodeImage(originalBytes);
    if (decoded == null) return null;

    final img.Image resized = img.copyResize(decoded, width: 512);
    return Uint8List.fromList(img.encodePng(resized));
  }

  Future<void> _shareAsSticker() async {
    if (_selectedImages == null) return;

    setState(() => _isSharing = true);

    try {
      final appDir = await getTemporaryDirectory();
      final stickersDirectory = Directory('${appDir.path}/stickers');
      await stickersDirectory.create(recursive: true);
      final trayPath = '${stickersDirectory.path}/tray_123.png';

      final bytes = await _selectedImages!.readAsBytes();
      final decoded = img.decodeImage(bytes)!;
      // Make canvas size = the longer side
      final size = decoded.width > decoded.height
          ? decoded.width
          : decoded.height;
      final padded = img.Image(
        width: size,
        height: size,
      ); // transparent by default

      // Center the original image on the canvas
      final offsetX = (size - decoded.width) ~/ 2;
      final offsetY = (size - decoded.height) ~/ 2;
      img.compositeImage(padded, decoded, dstX: offsetX, dstY: offsetY);

      final paddedFile = File('${stickersDirectory.path}/padded_.png');
      await paddedFile.writeAsBytes(img.encodePng(padded));

      final trayImage = await FlutterImageCompress.compressAndGetFile(
        paddedFile.path,
        trayPath,
        format: CompressFormat.png,
        quality: 100,
        minWidth: 96,
        minHeight: 96,
      );
      if (trayImage == null) throw Exception('Failed to create tray image');

      final stickerImage = <XFile>[];
      for (int i = 0; i < 5; i++) {
        final sticker = await FlutterImageCompress.compressAndGetFile(
          paddedFile.path,
          '${stickersDirectory.path}/sticker_$i.webp',
          format: CompressFormat.webp,
          quality: 80,
          minWidth: 512,
          minHeight: 512,
        );
        stickerImage.add(sticker!);
      }

      final stickerFiles = <String, List<String>>{
        stickerImage[0].path: ['☕', '🙂'],
        stickerImage[1].path: ['😄', '😀'],
        stickerImage[2].path: ['😆', '😂'],
        stickerImage[3].path: ['🧏‍♂️', '😂'],
        stickerImage[4].path: ['🙏', '🧏‍♂️'],
      };
      final stickerPack = StickerPack(
        identifier: 'cuppyFlutterWhatsAppStickers',
        name: 'StickerPack',
        publisher: 'Multimedia Sticker Maker',
        trayImagePath: trayImage.path,
        publisherWebsite: '',
        privacyPolicyWebsite: '',
        licenseAgreementWebsite: '',
      );
      stickerFiles.forEach((path, emoji) {
        stickerPack.addSticker(StickerModel.fromFile(File(path)), emoji);
      });
      await stickerPack.shareToWhatsApp();
      _showSnack('Sticker berhasil dikirim ke WhatsApp!');
    } on WhatsappStickersException catch (e) {
      debugPrint('WhatsappStickersException: ${e.cause}');
      _showSnack(e.cause.toString(), isError: true);
    } catch (e, st) {
      debugPrint('Error: $e\n$st');
      _showSnack('Gagal: $e', isError: true);
    } finally {
      setState(() => _isSharing = false);
    }
  }

  Future<void> _toggleSaveSticker() async {
    if (_selectedImages == null) return;
    HapticFeedback.mediumImpact();

    if (!_toggleSaveActive) {
      // Will save or update on exit
      final action = _isInitialStickerSaved
          ? _PendingAction.update
          : _PendingAction.save;
      setState(() {
        _pendingAction = action;
        _toggleSaveActive = true;
        _anyChanges = false;
      });
      _showSnack(
        _isInitialStickerSaved
            ? '✏️ Perubahan akan disimpan saat keluar'
            : '💾 Akan disimpan saat keluar',
      );
    } else {
      // Will delete on exit
      setState(() {
        _pendingAction = _PendingAction.delete;
        _toggleSaveActive = false;
      });
      _showSnack('🗑️ Akan dihapus saat keluar');
    }
  }

  void _showSnack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'monospace')),
        backgroundColor: isError
            ? const Color(0xFFE53E3E)
            : const Color(0xFF25D366),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      ),
    );
  }

  void _showPickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111A16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Pilih Sumber Gambar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PickerOption(
                    icon: Icons.photo_library_rounded,
                    label: 'Galeri',
                    color: const Color(0xFF25D366),
                    onTap: () async {
                      Navigator.pop(context);
                      final file = await _pickImage(fromCamera: false);
                      if (file != null) {
                        setState(() {
                          _selectedImages = file;
                          _currentSavedStickerId = null;
                          // _currentSticker = null;
                          if (_toggleSaveActive) {
                            _anyChanges = true;
                          }
                          _toggleSaveActive = false;
                          _isInitialStickerSaved = false;
                          _pendingAction = _PendingAction.none;
                        });

                        _slideController.forward(from: 0);
                        HapticFeedback.mediumImpact();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PickerOption(
                    icon: Icons.camera_alt_rounded,
                    label: 'Kamera',
                    color: const Color(0xFF128C7E),
                    onTap: () async {
                      Navigator.pop(context);
                      final file = await _pickImage(fromCamera: true);
                      if (file != null) {
                        setState(() {
                          _selectedImages = file;
                          _currentSavedStickerId = null;
                          // _currentSticker = null;
                          if (_toggleSaveActive) {
                            _anyChanges = true;
                          }
                          _toggleSaveActive = false;
                          _isInitialStickerSaved = false;
                          _pendingAction = _PendingAction.none;
                        });

                        _slideController.forward(from: 0);
                        HapticFeedback.mediumImpact();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111A16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DeleteConfirmModal(
        onConfirm: () {
          Navigator.pop(context);
          setState(() {
            _selectedImages = null;
            _slideController.reset();
          });
          HapticFeedback.mediumImpact();
          _showSnack('🗑️ Gambar dihapus');
        },
      ),
    );
  }

  Widget _emptyImageCard() {
    return GestureDetector(
      onTap: _showPickerDialog,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (_, child) =>
            Transform.scale(scale: _pulseAnimation.value, child: child),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: const Color(0xFF25D366).withValues(alpha: 0.25),
              width: 2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF111A16), const Color(0xFF0D1610)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF25D366).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFF25D366).withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  size: 44,
                  color: Color(0xFF25D366),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tap untuk upload gambar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih dari galeri atau ambil foto\nGambar akan diubah jadi stiker 512×512px',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.45),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              // Info chips
              Wrap(
                spacing: 10,
                children: [
                  _infoChip(Icons.crop_square_rounded, '512×512'),
                  _infoChip(Icons.image_rounded, 'PNG/JPG'),
                  _infoChip(Icons.phone_android_rounded, 'WhatsApp'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF25D366).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF25D366).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF25D366)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF25D366),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
