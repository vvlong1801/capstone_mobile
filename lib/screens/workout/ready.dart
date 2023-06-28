import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/providers/workout/controller/audio_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/countdown_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/workout/countdown.dart';

class ReadyPage extends ConsumerStatefulWidget {
  ReadyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadyPageState();
}

class _ReadyPageState extends ConsumerState<ReadyPage> {
  late SessionExercise nextExercise;
  late String nextRoute;
  @override
  void initState() {
    super.initState();
    // print(widget.exercises);
    // ref.read(workoutProvider.notifier).initState(widget.exercises);
    nextExercise = ref.read(workoutProvider.notifier).getCurrentExercise();
    nextRoute = nextExercise.requirementUnit == "reps"
        ? countStepRoute
        : countDownRoute;
    ref.read(readyTimerController.notifier).run();
    ref.read(audioPlayerController.notifier).play();
  }

  double? calcProgressValue(int max, int current) {
    return (max - current) / max;
  }

  @override
  Widget build(BuildContext context) {
    // final time = ref.watch(readyTimerController);
    final controller = ref.read(readyTimerController.notifier);

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
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    nextExercise.image!.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/challenge-2.jpeg",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "Get Ready!",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              const Center(
                child: Text(
                  "jumping",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CountDown(
                controller: readyTimerController,
                build: (_, int time) => SizedBox(
                  height: 160,
                  width: 160,
                  child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                      // value: calcProgressValue(controller.timeStart, time),
                      value: calcProgressValue(controller.startTime, time),
                      color: Colors.deepPurple,
                      backgroundColor: Colors.black26,
                      strokeWidth: 14,
                    ),
                    Center(
                        child: Text(
                      time.toInt().toString(),
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    )),
                  ]),
                ),
                onFinished: () {
                  controller.restart();
                  GoRouter.of(context).goNamed(nextRoute);
                },
              ),
              const SizedBox(
                height: 40,
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
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 14))),
                child: const Center(
                  child: Text(
                    "Start Over",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
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
