import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/my_plan_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';

class SessionPage extends ConsumerWidget {
  int sessionIndex;
  int phaseIndex;

  SessionPage({super.key, required this.sessionIndex, this.phaseIndex = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planId = ref.read(planController.notifier).planId;
    final schedule = ref.watch(getScheduleProvider(planId));
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: schedule.when(data: (data) {
            final session = data[phaseIndex].sessions[sessionIndex];
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Minutes",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "22",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "KCAL",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              session.exercises.length.toString(),
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "Exercise",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Exercises",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    // Text("(5)")
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: session.exercises.length,
                    itemBuilder: (BuildContext context, int index) {
                      final exercise = session.exercises[index];
                      return ListTile(
                        onTap: () {
                          GoRouter.of(context).pushNamed(detailExerciseRoute);
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 80,
                            height: 60,
                            child: Image.network(
                              exercise.image.url,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                "assets/images/challenge-2.jpeg",
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(exercise.name),
                        subtitle: Text(
                            "${exercise.requirement} ${exercise.requirementUnit}"),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                      );
                    },
                  ),
                )
              ],
            );
          }, error: (error, StackTrace) {
            return Text(error.toString());
          }, loading: () {
            return const Center(
                child: SizedBox(
                    width: 60, height: 60, child: CircularProgressIndicator()));
          }),
        ),
        floatingActionButton: schedule.when(
            data: (data) {
              return FloatingActionButton.extended(
                  onPressed: () {
                    final exercises =
                        data[phaseIndex].sessions[sessionIndex].exercises;
                    ref.read(workoutProvider.notifier).initState(exercises);
                    GoRouter.of(context).goNamed(
                      readyRoute,
                    );
                  },
                  backgroundColor: Colors.deepPurple,
                  label: Container(
                      width: MediaQuery.of(context).size.width * 0.9 - 28,
                      alignment: Alignment.center,
                      child: const Text(
                        "Start",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )));
            },
            error: (error, StackTrace) {},
            loading: () {}));
  }
}
