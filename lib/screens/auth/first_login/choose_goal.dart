import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';

class ChooseGoalPage extends ConsumerStatefulWidget {
  const ChooseGoalPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChooseGoalPageState();
}

class _ChooseGoalPageState extends ConsumerState<ChooseGoalPage> {
  late List choosedGoals;

  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(listGoalData);
    choosedGoals = ref.watch(profileProvider).goals ?? [];
    // print(choosedGoals);
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
                    "What is Your Goal?",
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
                  child: goals.when(data: (data) {
                return GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 80),
                    itemBuilder: (context, index) {
                      final existed =
                          choosedGoals.any((goal) => goal.id == data[index].id);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            existed
                                ? choosedGoals.removeWhere(
                                    (element) => element.id == data[index].id)
                                : choosedGoals.add(data[index]);
                            ref
                                .read(profileProvider.notifier)
                                .setGoals(choosedGoals);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: existed ? Colors.deepPurple : Colors.white,
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              data[index].name,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: existed ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      );
                    });
              }, error: (error, _) {
                return const Center(
                  child: Text("fail"),
                );
              }, loading: () {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              })),
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
                          GoRouter.of(context).goNamed(chooseHeightRoute);
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
                          GoRouter.of(context).goNamed(chooseLevelRoute);
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
