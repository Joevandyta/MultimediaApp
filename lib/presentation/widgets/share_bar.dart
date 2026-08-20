import 'package:flutter/material.dart';

class ShareBar extends StatelessWidget {
  /// Called when the toggle button is tapped.
  /// - When [isSaved] is false → acts as Save
  /// - When [isSaved] is true  → acts as Delete (caller should show confirmation)
  final VoidCallback onToggle;

  /// Called when the "View Pack" button is tapped.
  final VoidCallback onViewPack;

  final bool isSaving;
  final bool isDeleting;
  final bool isSaved;

  const ShareBar({
    super.key,
    required this.onToggle,
    required this.onViewPack,
    required this.isSaving,
    required this.isDeleting,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    final busy = isSaving || isDeleting;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // ── Toggle button: Save ↔ Delete ──────────────────────────────
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: busy ? null : onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isSaved
                      ? Colors.red.withValues(alpha: 0.12)
                      : const Color(0xFF111A16),
                  border: Border.all(
                    color: isSaved
                        ? Colors.redAccent.withValues(alpha: 0.4)
                        : const Color(0xFF25D366).withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: (isSaving || isDeleting)
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: isSaved
                                ? Colors.redAccent
                                : const Color(0xFF25D366),
                          ),
                        )
                      : Icon(
                          isSaved
                              ? Icons.delete_outline_rounded
                              : Icons.bookmark_add_outlined,
                          color: isSaved
                              ? Colors.redAccent
                              : const Color(0xFF25D366),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── View Pack button ───────────────────────────────────────────
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: busy ? null : onViewPack,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF25D366).withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.grid_view_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'View Pack',
                      style: TextStyle(
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
