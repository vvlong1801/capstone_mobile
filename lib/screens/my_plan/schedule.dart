import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/plan.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/my_plan_controller.dart';
import 'package:user_side_final_project/widgets/my_plan/schedule_widget.dart';

class SchedulePage extends ConsumerWidget {
  late int? planId;
  SchedulePage({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue plan = ref.read(planController.notifier).getPlanById(planId);
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(14.0),
          child: plan.when(data: (data) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      data.challenge.name ?? "",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: ScheduleWidget(
                      totalSession: int.parse(data.challenge.totalSessions),
                      currentSession: data.currentSession,
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),

              ],
            );
          }, error: (error, StackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          }, loading: () {
            return SizedBox(
                width: 60, height: 60, child: CircularProgressIndicator());
          })),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {
      //       GoRouter.of(context).goNamed(readyRoute);
      //     },
      //     backgroundColor: Colors.deepPurple,
      //     label: Container(
      //         width: MediaQuery.of(context).size.width * 0.9 - 28,
      //         alignment: Alignment.center,
      //         child: Text(
      //           "Start",
      //           style: TextStyle(
      //               fontSize: 22,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.white),
      //         ))),
    );
  }
}
