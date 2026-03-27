import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/floating_nav_bar.dart';

/// Shell widget that wraps the main tab screens with the floating nav bar.
class NavShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const NavShell({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.navigationShell.currentIndex);
  }

  @override
  void didUpdateWidget(covariant NavShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.navigationShell.currentIndex != widget.navigationShell.currentIndex) {
      _pageController.animateToPage(
        widget.navigationShell.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The active tab's content with smooth swipe capability
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              if (index != widget.navigationShell.currentIndex) {
                widget.navigationShell.goBranch(index);
              }
            },
            children: widget.children,
          ),
          // Floating nav bar pinned at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(navigationShell: widget.navigationShell,),
          ),
        ],
      ),
    );
  }
}
