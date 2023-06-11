import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/controller/navigation_controller.dart';

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentIndex = ref.watch(navigationProvider);
    return BottomNavigationBar(
        unselectedItemColor: Colors.black12,
        selectedItemColor: Colors.deepPurple,
        currentIndex: currentIndex,
        onTap: (value) => _onTap(value, context, ref),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: 'My Plan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded), label: 'Bookmark'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Setting'),
        ]);
  }

  void _onTap(int index, BuildContext context, WidgetRef ref) {
    ref.read(navigationProvider.notifier).updateCurrentIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/my-plan');
        break;
      case 2:
        GoRouter.of(context).go('/explore');
        break;
      case 3:
        GoRouter.of(context).go('/message');
        break;
      case 4:
        GoRouter.of(context).go('/setting');
        break;
      default:
    }
  }
}
