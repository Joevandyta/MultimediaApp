
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                title: const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _settingsGroupHeader('Aplikasi'),
                  _settingsTile(
                    icon: Icons.palette_rounded,
                    title: 'Tema Aplikasi',
                    subtitle: 'Gelap (Bawaan)',
                    onTap: () => _showTodoToast('Tema Aplikasi'),
                  ),
                  _settingsTile(
                    icon: Icons.high_quality_rounded,
                    title: 'Kualitas Stiker',
                    subtitle: 'Tinggi (512x512px)',
                    onTap: () => _showTodoToast('Kualitas Stiker'),
                  ),
                  const SizedBox(height: 24),
                  _settingsGroupHeader('Penyimpanan & Cadangan'),
                  _settingsTile(
                    icon: Icons.cloud_upload_rounded,
                    title: 'Cadangkan Stiker',
                    subtitle: 'Simpan ke cloud storage',
                    onTap: () => _showTodoToast('Cadangkan Stiker'),
                  ),
                  _settingsTile(
                    icon: Icons.restore_rounded,
                    title: 'Pulihkan Stiker',
                    subtitle: 'Kembalikan dari cadangan sebelumnya',
                    onTap: () => {
                      _showTodoToast('Pulihkan Stiker')
                    },
                  ),
                  const SizedBox(height: 24),
                  _settingsGroupHeader('Bantuan & Tentang'),
                  _settingsTile(
                    icon: Icons.info_outline_rounded,
                    title: 'Tentang Stickerify',
                    subtitle: 'Versi 1.0.0',
                    onTap: () => _showTodoToast('Tentang Stickerify'),
                  ),
                  _settingsTile(
                    icon: Icons.help_outline_rounded,
                    title: 'Pusat Bantuan',
                    subtitle: 'Pertanyaan umum & panduan',
                    onTap: () => _showTodoToast('Pusat Bantuan'),
                  ),
                  const SizedBox(height: 120), // Bottom space for bottom bar
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsGroupHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF00FF41),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111A16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00FF41).withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF25D366).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF25D366), size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.45),
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showTodoToast(String featureName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.construction_rounded,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Fitur "$featureName" sedang dalam pengembangan!',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00FF41),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 110),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
