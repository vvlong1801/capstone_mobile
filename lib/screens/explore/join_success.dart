import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';

class JoinSuccessPage extends ConsumerWidget {
  const JoinSuccessPage({super.key});

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
                  height: 14,
                ),
                const Text("Click the button below to start workout"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(planController.notifier).fetchPlans();
                    ref.read(exploreController.notifier).getChallenges();
                    GoRouter.of(context).goNamed(exploreRoute);
                  },
                  label: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      "Return Discover",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
