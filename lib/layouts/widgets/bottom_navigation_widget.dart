import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/controller/navigation_controller.dart';

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
              icon: Icon(Icons.analytics_outlined), label: 'Insight'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]);
  }

  void _onTap(int index, BuildContext context, WidgetRef ref) {
    ref.read(navigationProvider.notifier).updateCurrentIndex(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/my-plan');
        break;
      case 1:
        GoRouter.of(context).go('/');
        break;
      case 2:
        GoRouter.of(context).go('/explore');
        break;
      case 3:
        GoRouter.of(context).go('/setting');
        break;
      default:
    }
  }
}
