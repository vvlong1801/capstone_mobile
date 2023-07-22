import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/profile_provider.dart';

class ChooseGenderPage extends ConsumerWidget {
  const ChooseGenderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(profileProvider).gender;
    debugPrint("gender: $gender");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        "Tell Us About Yourself",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600),
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
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => ref
                            .read(profileProvider.notifier)
                            .setGender("male"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: gender == "male"
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                            child: const Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.male_outlined,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () => ref
                            .read(profileProvider.notifier)
                            .setGender("female"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: Container(
                            height: 200,
                            width: 200,
                            color: gender == "female"
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                            child: const Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.female_outlined,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.deepPurple)),
                            onPressed: () {
                              GoRouter.of(context).goNamed(chooseAgeRoute);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
