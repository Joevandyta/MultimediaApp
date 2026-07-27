import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

@Preview(name: 'navPreview')
Widget navPreview() {
  return MainNavigation();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: Colors.transparent,
      navBarOverlap: const NavBarOverlap.full(),
      tabs: [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home_rounded),
            title: 'Beranda',
          ),
        ),
        PersistentTabConfig(
          screen: const SettingsScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.settings_rounded),
            title: 'Pengaturan',
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) {
        return CustomNotchedNavBar(navBarConfig: navBarConfig);
      },
    );
  }
}

class CustomNotchedNavBar extends StatelessWidget {
  final NavBarConfig navBarConfig;

  const CustomNotchedNavBar({super.key, required this.navBarConfig});

  @override
  Widget build(BuildContext context) {
    // Total height of the navbar area is 130 to fully enclose the FAB and margins without clipping.
    return SafeArea(
      top: false,
      child: Container(
        height: 130,
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. Floating Notched Background Bar
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: CustomPaint(
                painter: NotchedNavBarPainter(
                  notchRadius: 46,
                  borderRadius: 20,
                  backgroundColor: const Color(
                    0xFF111A16,
                  ).withValues(alpha: 0.85),
                  borderColor: const Color(0xFF00FF41).withValues(alpha: 0.3),
                ),
                child: ClipPath(
                  clipper: NotchedNavBarClipper(
                    notchRadius: 46,
                    borderRadius: 20,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      height: 76,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          for (final (index, item)
                              in navBarConfig.items.indexed)
                            Expanded(
                              child: InkWell(
                                onTap: () => navBarConfig.onItemSelected(index),
                                child: _buildNavItem(
                                  item,
                                  navBarConfig.selectedIndex == index,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 2. Prominent FAB (sits partially above the bar)
            Positioned(
              left: 0,
              right: 0,
              // Top edge of the notched bar is at bottom = 24 + 76 = 100.
              // To sit halfway above the bar, the center of the FAB (height 60) should be at 100.
              // This places the bottom of the FAB at bottom = 100 - 30 = 70.
              bottom: 65,
              child: Center(
                child: _ProminentFAB(
                  onPressed: () {
                    context.push('/editor');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(ItemConfig item, bool isSelected) {
    final color = isSelected
        ? const Color(0xFF00FF41)
        : Colors.white.withValues(alpha: 0.45);
    final title = item.title;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isSelected
              ? (item.icon as Icon).icon
              : (item.inactiveIcon as Icon).icon,
          color: color,
        ),
        if (title != null) ...[
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProminentFAB extends StatefulWidget {
  final VoidCallback onPressed;

  const _ProminentFAB({required this.onPressed});

  @override
  State<_ProminentFAB> createState() => _ProminentFABState();
}

class _ProminentFABState extends State<_ProminentFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF00FF41), Color(0xFF00D9A3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF41).withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: const Icon(Icons.add_rounded, color: Colors.black, size: 32),
        ),
      ),
    );
  }
}

Path getNotchedPath(Size size, double borderRadius, double notchRadius) {
  final path = Path();
  final width = size.width;
  final height = size.height;

  // Start at top-left
  path.moveTo(0, borderRadius);
  path.quadraticBezierTo(0, 0, borderRadius, 0);

  // Go to the start of the notch
  final notchWidth = notchRadius * 2.8;
  final notchStart = (width - notchWidth) / 2;
  path.lineTo(notchStart, 0);

  // Curve into the notch using smooth cubic bezier curves
  final controlPoint1 = Offset(notchStart + notchWidth * 0.25, 0);
  final controlPoint2 = Offset(
    notchStart + notchWidth * 0.10, // was 0.3
    notchRadius * 1.05, // was 1.0
  );
  final controlPoint3 = Offset(
    width - (notchStart + notchWidth * 0.10), // was 0.3
    notchRadius * 1.05, // was 1.0
  );
  final controlPoint4 = Offset(width - (notchStart + notchWidth * 0.25), 0);
  final endPoint = Offset(width / 2, notchRadius * 1.05); //depth of notch

  path.cubicTo(
    controlPoint1.dx,
    controlPoint1.dy,
    controlPoint2.dx,
    controlPoint2.dy,
    endPoint.dx,
    endPoint.dy,
  );

  final notchEnd = width - notchStart;

  path.cubicTo(
    controlPoint3.dx,
    controlPoint3.dy,
    controlPoint4.dx,
    controlPoint4.dy,
    notchEnd,
    0,
  );

  // Go to top-right
  path.lineTo(width - borderRadius, 0);
  path.quadraticBezierTo(width, 0, width, borderRadius);

  // Go to bottom-right
  path.lineTo(width, height - borderRadius);
  path.quadraticBezierTo(width, height, width - borderRadius, height);

  // Go to bottom-left
  path.lineTo(borderRadius, height);
  path.quadraticBezierTo(0, height, 0, height - borderRadius);

  path.close();
  return path;
}

class NotchedNavBarClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double borderRadius;

  NotchedNavBarClipper({required this.notchRadius, required this.borderRadius});

  @override
  Path getClip(Size size) {
    return getNotchedPath(size, borderRadius, notchRadius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class NotchedNavBarPainter extends CustomPainter {
  final double notchRadius;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;

  NotchedNavBarPainter({
    required this.notchRadius,
    required this.borderRadius,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = getNotchedPath(size, borderRadius, notchRadius);

    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Draw shadow
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.5), 10.0, true);

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
