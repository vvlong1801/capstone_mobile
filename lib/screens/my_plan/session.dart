import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';

// ignore: must_be_immutable
class SessionPage extends ConsumerWidget {
  int sessionIndex;
  int phaseIndex;

  SessionPage({super.key, required this.sessionIndex, this.phaseIndex = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planId = ref.read(planController.notifier).planId;
    final schedule = ref.watch(getScheduleProvider(planId));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Session",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: schedule.when(data: (data) {
            final session = data[phaseIndex].sessions[sessionIndex];
            ref.read(workoutProvider.notifier).phaseSessionId = session.id;
            return session.exercises.length == 0
                ? emptyWidget()
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Exercises",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("(${session.exercises.length})")
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
                                GoRouter.of(context)
                                    .pushNamed(detailExerciseRoute);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 80,
                                  height: 60,
                                  child: Image.network(
                                    exercise.image.url,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
          }, error: (error, _) {
            return Text(error.toString());
          }, loading: () {
            return const Center(
                child: SizedBox(
                    width: 60, height: 60, child: CircularProgressIndicator()));
          }),
        ),
        floatingActionButton: schedule.when(data: (data) {
          var totalExercises =
              data[phaseIndex].sessions[sessionIndex].exercises.length;
          return totalExercises == 0
              ? null
              : FloatingActionButton.extended(
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
        }, error: (error, _) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }, loading: () {
          return const SizedBox(
              width: 60, height: 60, child: CircularProgressIndicator());
        }));
  }

  Widget emptyWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "session data has not been initialized",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
