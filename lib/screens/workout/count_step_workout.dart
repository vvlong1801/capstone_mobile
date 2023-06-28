import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/session_exercise.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/workout/workout_bottom.dart';

class CountStepPage extends ConsumerStatefulWidget {
  const CountStepPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountStepPageState();
}

class _CountStepPageState extends ConsumerState<CountStepPage> {
  late SessionExercise currentExercise;
  late String nextRoute;
  @override
  void initState() {
    super.initState();
    currentExercise = ref.read(workoutProvider.notifier).getCurrentExercise();
    nextRoute = ref.read(workoutProvider.notifier).checkCompleted()
        ? congratulationRoute
        : restRoute;
  }

  @override
  Widget build(BuildContext context) {
    final mediaUrl =
        currentExercise.data.gif!.url ?? currentExercise.data.image?.url;
    return Scaffold(
      appBar: WorkoutAppBarWidget(
        actionExit: () {
          ref.read(workoutProvider.notifier).reset();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mediaUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/challenge-2.jpeg",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )),
              Column(
                children: [
                  Text(
                    currentExercise.name ?? "No Name",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "${currentExercise.requirement.toString()} ${currentExercise.requirementUnit.toString()}",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            nextRoute == congratulationRoute
                                ? ref.read(workoutProvider.notifier).reset()
                                : ref
                                    .read(workoutProvider.notifier)
                                    .currentIndex++;

                            GoRouter.of(context).pushNamed(nextRoute);
                          },
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 100,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 50,
                      )
                    ],
                  ),
                ],
              ),
              WorkoutBottom(),
            ],
          ),
        ),
      ),
    );
  }
}