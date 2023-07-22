import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/profile_provider.dart';

class ChooseLevelPage extends ConsumerWidget {
  const ChooseLevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(profileProvider).level;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
        child: Center(
          child: Column(
            children: [
              const Column(
                children: [
                  Text(
                    "Physical Activity Level?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "To give you a better experience and results",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    "we need to know your gender",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ref
                              .read(profileProvider.notifier)
                              .setLevel("beginner");
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                level == "beginner"
                                    ? Colors.deepPurple
                                    : Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.deepPurple)))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Beginner",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: level == "beginner"
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        onPressed: () {
                          ref
                              .read(profileProvider.notifier)
                              .setLevel("intermediate");
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                level == "intermediate"
                                    ? Colors.deepPurple
                                    : Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.deepPurple)))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Intermediate",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: level == "intermediate"
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                level == "advanced"
                                    ? Colors.deepPurple
                                    : Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.deepPurple)))),
                        onPressed: () {
                          ref
                              .read(profileProvider.notifier)
                              .setLevel("advanced");
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Advanced",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: level == "advanced"
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade200)),
                        onPressed: () {
                          GoRouter.of(context).goNamed(chooseGoalRoute);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Back",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.deepPurple)),
                        onPressed: () {
                          GoRouter.of(context).goNamed(fillProfileRoute);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
