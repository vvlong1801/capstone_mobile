import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/audio_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';

class CongratulationPage extends ConsumerStatefulWidget {
  const CongratulationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CongratulationPageState();
}

class _CongratulationPageState extends ConsumerState<CongratulationPage> {
  late Duration? timeWorkout;
  late bool completeChallenge;
  double? kcal;
  double? bpm;
  TextEditingController feedbackInputController = TextEditingController();

  @override
  void initState() {
    // timeWorkout = ref.read(workoutProvider.notifier).getTimeWorkout();

    // ref.read(workoutProvider.notifier).getWorkoutData();
    ref.read(workoutController.notifier).getWorkoutData();
    kcal = ref.read(workoutController.notifier).calo;
    bpm = ref.read(workoutController.notifier).heartRate;
    // kcal = ref.read(workoutProvider.notifier).caloriesBurned;
    // bpm = ref.read(workoutProvider.notifier).bpm;
    // completeChallenge = ref.read(planController.notifier).checkCompletePlan();
    completeChallenge = ref.read(completePlanProvider);
    debugPrint("ban da ket thuc buoi tap luyen");
    super.initState();
  }

  void onClickHome() {
    ref.read(audioPlayerController.notifier).pause();
    ref.read(workoutController.notifier).sendResult();
    if (completeChallenge) {
      GoRouter.of(context).goNamed(completedChallengeRoute);
    } else {
      GoRouter.of(context).goNamed(myPlanRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.read(workoutController.notifier).updateEndTime(DateTime.now());
    print(ref.read(workoutController.notifier).startTime);
    print(ref.read(workoutController.notifier).endTime);
    timeWorkout = ref.read(workoutController.notifier).timeWorkout;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset("assets/images/congratulation_cup.png"),
              const Center(
                child: Text(
                  "Congratulation",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              timeWorkout!.inSeconds.toString(),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              "seconds",
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Card(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              kcal != 0.0 ? kcal.toString() : "...",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              "calories",
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Card(
                      child: Builder(builder: (context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bpm != 0.0 ? bpm.toString() : "...",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "heart rate",
                                style: const TextStyle(color: Colors.black38),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      final feedback = await showFeedbackDialog();
                      // ref.read(workoutProvider.notifier).feedback = feedback;
                      ref
                          .read(workoutController.notifier)
                          .updateFeedback(feedback ?? "");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Feedback",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)))),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  TextButton(
                      onPressed: () => onClickHome(),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black38),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)))),
                      child: const InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "HOME",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> showFeedbackDialog() => showDialog(
      context: context,
      builder: (context) {
        return feedbackModalWidget(context);
      });

  Widget feedbackModalWidget(context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        width: 400,
        child: TextField(
          maxLines: 8,
          controller: feedbackInputController,
          decoration: InputDecoration(hintText: "Enter feedback"),
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              GoRouter.of(context).pop(feedbackInputController.text);
              feedbackInputController.clear();
            },
            child: Text("Save")),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
