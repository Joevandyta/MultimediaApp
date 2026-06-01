import 'package:flutter/material.dart';

class ShareBar extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onSave;
  final bool isSharing;
  final bool isSaving;
  final bool isSaved;

  const ShareBar({
    super.key,
    required this.onShare,
    required this.onSave,
    required this.isSharing,
    required this.isSaving,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Tombol Save
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: (isSharing || isSaving) ? null : onSave,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF111A16),
                  border: Border.all(
                    color: const Color(0xFF25D366).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF25D366),
                          ),
                        )
                      : Icon(
                          isSaved
                              ? Icons.bookmark_added_rounded
                              : Icons.bookmark_add_outlined,
                          color: const Color(0xFF25D366),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Tombol Share
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: (isSharing || isSaving) ? null : onShare,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: isSharing
                        ? [const Color(0xFF128C7E), const Color(0xFF075E54)]
                        : [const Color(0xFF25D366), const Color(0xFF128C7E)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF25D366).withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSharing)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    else
                      const Icon(
                        Icons.phone_android_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    const SizedBox(width: 10),
                    Text(
                      isSharing ? 'Sharing...' : 'Share ke WhatsApp',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
