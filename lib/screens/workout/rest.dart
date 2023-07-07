import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/providers/workout/controller/countdown_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/workout/countdown.dart';

class RestPage extends ConsumerStatefulWidget {
  const RestPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestPageState();
}

class _RestPageState extends ConsumerState<RestPage> {
  late String nextRoute;
  late SessionExercise nextExercise;
  @override
  void initState() {
    super.initState();
    nextRoute = ref.read(workoutProvider.notifier).getNextRoute();
    nextExercise = ref.read(workoutProvider.notifier).getCurrentExercise();
    ref.read(restTimerController.notifier).run();
  }

  double? calcProgressValue(int max, int current) {
    return (max - current) / max;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(restTimerController.notifier);
    final progress = ref.read(workoutProvider.notifier).getProgress();

    return Scaffold(
      appBar: WorkoutAppBarWidget(
        actionLeading: controller.pause,
        actionContinue: controller.run,
        actionExit: () {
          ref.read(workoutProvider.notifier).reset();
          controller.restart();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "REST",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.addSeconds(20);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black26),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "+20s",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        controller.restart();
                        GoRouter.of(context).goNamed(nextRoute);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CountDown(
                controller: restTimerController,
                build: (_, int time) => SizedBox(
                  height: 160,
                  width: 160,
                  child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                      value: calcProgressValue(controller.startTime, time),
                      color: Colors.deepPurple,
                      backgroundColor: Colors.black26,
                      strokeWidth: 14,
                    ),
                    Center(
                      child: Text(
                        "$time",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                    )
                  ]),
                ),
                onFinished: () {
                  controller.restart();
                  GoRouter.of(context).goNamed(countDownRoute);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next $progress",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Text(
                        nextExercise.name ?? "No Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  ),
                  Text(
                    "${nextExercise.requirement} ${nextExercise.requirementUnit}",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  nextExercise.image!.url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/challenge-2.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
