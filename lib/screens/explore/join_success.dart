import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_test_controller.dart';

// ignore: must_be_immutable
class JoinSuccessPage extends ConsumerWidget {
  String redirectRoute;
  JoinSuccessPage({super.key, required this.redirectRoute});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_done,
                  color: Colors.green,
                  size: 140,
                ),
                const Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "you have been accepted",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(planController.notifier).fetchPlans();
                    ref.read(exploreController.notifier).getChallenges();
                    GoRouter.of(context).goNamed(redirectRoute);
                  },
                  label: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    child: Text(
                      redirectRoute == exploreRoute ? "Discover" : "Invitation",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
