import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/providers/workout/controller/countdown_exercise_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/workout/countdown.dart';
import 'package:user_side_final_project/widgets/workout/workout_bottom.dart';

final container = ProviderContainer();

class CountDownPage extends ConsumerStatefulWidget {
  const CountDownPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountDownPageState();
}

class _CountDownPageState extends ConsumerState<CountDownPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late SessionExercise currentExercise;
  late String nextRoute;

  @override
  void initState() {
    super.initState();
    currentExercise = ref.read(workoutProvider.notifier).getCurrentExercise();
    // ref.read(initCountdownExercise.notifier).state =
    //     int.parse(currentExercise.requirement!);
    nextRoute = ref.read(workoutProvider.notifier).checkCompleted()
        ? congratulationRoute
        : restRoute;
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (ref.watch(readyCountDownProvider) > 0) {
          --ref.read(readyCountDownProvider.notifier).state;
          _animationController.reset();
          _animationController.forward();
        } else {
          _animationController.clearListeners();
          ref.read(readyCountDownProvider.notifier).state = 3;
          ref.read(countdownExerciseController.notifier).run();
        }
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final int num = ref.watch(readyCountDownProvider);
    final controller = ref.read(countdownExerciseController.notifier);
    final iconCountDown = ref.watch(iconCountDownProvider);
    final mediaUrl =
        currentExercise.data.gif?.url ?? currentExercise.data.image?.url;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      mediaUrl!,
                      fit: BoxFit.cover,
                      width: 1000,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 1000.0,
                        fit: BoxFit.cover,
                      ),
                    )),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        // ignore: unnecessary_null_comparison
                        child: _animationController.isAnimating
                            ? Center(
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Text(
                                      "$num",
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ])
              ]),
              Column(
                children: [
                  Text(
                    currentExercise.name ?? "NO NAME",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CountDown(
                    controller: countdownExerciseController,
                    build: (_, int time) => Text(
                      "00:${time.toString().padLeft(2, "0")}",
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurple),
                    ),
                    onFinished: () {
                      controller.restart();
                      nextRoute == congratulationRoute
                          ? ref.read(workoutProvider.notifier).reset()
                          : ref.read(workoutProvider.notifier).currentIndex++;
                      GoRouter.of(context).goNamed(nextRoute);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iconCountDown == "paused") {
                            controller.run();
                          } else {
                            controller.pause();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: iconCountDown == "running"
                              ? Icon(
                                  Icons.pause_circle_rounded,
                                  size: 100,
                                  color: Colors.deepPurple,
                                )
                              : Icon(
                                  Icons.stop_circle_rounded,
                                  size: 100,
                                  color: Colors.deepPurple,
                                ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 50,
                      ),
                    ],
                  ),
                ],
              ),
              WorkoutBottom(
                  actionBeforeShowModal: controller.pause,
                  actionAfterShowModal: () => controller.run()),
            ],
          ),
        ),
      ),
    );
  }
}
