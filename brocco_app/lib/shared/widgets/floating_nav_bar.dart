import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({super.key});

  static const _items = [
    _NavItem(label: 'Profil', icon: Icons.person_outline_rounded, route: '/profile'),
    _NavItem(label: 'Kuchnia', icon: Icons.soup_kitchen_outlined, route: '/'),
    _NavItem(label: 'Szukaj', icon: Icons.search_rounded, route: '/browser'),
    _NavItem(label: 'Ustawienia', icon: Icons.settings_outlined, route: '/settings'),
  ];

  static int _indexForLocation(String location) {
    if (location.startsWith('/profile')) return 0;
    if (location == '/') return 1;
    if (location.startsWith('/browser')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _indexForLocation(location);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.accentGreen, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentGreen.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final item = _items[i];
            final isSelected = i == selectedIndex;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.go(item.route),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentGreen.withOpacity(0.18)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 24,
                        color: isSelected
                            ? AppColors.primaryOrange
                            : AppColors.greyText,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryText
                              : AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;
  const _NavItem({required this.label, required this.icon, required this.route});
}
