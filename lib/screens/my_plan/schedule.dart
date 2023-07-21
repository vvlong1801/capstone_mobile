import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/common/tag_widget.dart';
import 'package:user_side_final_project/widgets/my_plan/schedule_widget.dart';

// ignore: must_be_immutable
class SchedulePage extends ConsumerWidget {
  late int? planId;
  SchedulePage({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(workoutProvider.notifier).planId = planId!;
    AsyncValue plan = ref.read(planController.notifier).getPlanById(planId);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: plan.when(data: (data) {
              debugPrint("ban dang xem ${data.challenge.name}");
              return Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        data.challenge.name ?? "",
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 400),
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ScheduleWidget(
                      totalSession: int.parse(data.challenge.totalSessions),
                      currentSession: data.currentSession,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(maxHeight: 88, minHeight: 40),
                    child: GridView.builder(
                        itemCount: data.challenge.tags.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 40),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: Colors.deepPurple,
                                child: Center(
                                    child: Text(
                                  data.challenge.tags[index].name,
                                  style: const TextStyle(color: Colors.white),
                                ))),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            child: Text("A"),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            data.challenge.createdBy,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye_rounded,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    data.challenge.description,
                    overflow: TextOverflow.visible,
                  ),
                ],
              );
            }, error: (error, StackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            }, loading: () {
              return const SizedBox(
                  width: 60, height: 60, child: CircularProgressIndicator());
            }),
          )),
    );
  }
}
