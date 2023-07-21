import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';

class ChooseWeightPage extends ConsumerStatefulWidget {
  const ChooseWeightPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChooseWeightPageState();
}

class _ChooseWeightPageState extends ConsumerState<ChooseWeightPage> {
  late FixedExtentScrollController _scrollController;
  late int? weight;
  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateToItem(weight!,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    weight = ref.watch(profileProvider).weight!;
    debugPrint("weight: $weight");
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
                    "What is Your Weight?",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                          width: 70,
                          child: ListWheelScrollView.useDelegate(
                            controller: _scrollController,
                            overAndUnderCenterOpacity: 0.5,
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 2.5,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (value) {
                              ref
                                  .read(profileProvider.notifier)
                                  .setWeight(value);
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 200,
                                builder: (context, index) {
                                  return Center(
                                    child: Text(
                                      "$index",
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  );
                                }),
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "kg",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
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
                          GoRouter.of(context).goNamed(chooseAgeRoute);
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
                          GoRouter.of(context).goNamed(chooseHeightRoute);
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
