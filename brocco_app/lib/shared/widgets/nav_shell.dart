import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/floating_nav_bar.dart';

/// Shell widget that wraps the main tab screens with the floating nav bar.
class NavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The active tab's content
          navigationShell,
          // Floating nav bar pinned at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}
