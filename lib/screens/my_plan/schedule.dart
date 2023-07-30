import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/providers/workout/controller/workout_controller.dart';
import 'package:user_side_final_project/widgets/common/comment_widget.dart';
import 'package:user_side_final_project/widgets/my_plan/schedule_widget.dart';

// ignore: must_be_immutable
class SchedulePage extends ConsumerStatefulWidget {
  int? planId;
  SchedulePage({super.key, required this.planId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  late AsyncValue feedbacks;
  @override
  void initState() {
    ref.read(workoutProvider.notifier).planId = widget.planId!;
    feedbacks = ref.refresh(listFeedbackProvider(widget.planId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue plan =
        ref.read(planController.notifier).getPlanById(widget.planId);
    feedbacks = ref.watch(listFeedbackProvider(widget.planId!));
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: plan.when(data: (data) {
              debugPrint("ban dang xem ${data.challenge.name}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.challenge.name ?? "",
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(detailChallengeRoute,
                              pathParameters: {
                                'id': data.challenge.id.toString()
                              });
                        },
                        child: const Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "Detail",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurple),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.deepPurple,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 100, maxHeight: 300),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Feedbacks",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(commentRoute,
                              pathParameters: {
                                'id': data.challenge.id.toString()
                              });
                        },
                        child: const Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "Comments",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurple),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.deepPurple,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Column(
                    children: feedbacks.when(
                        data: (value) {
                          return listFeedbacks(value);
                        },
                        error: (error, _) => [const Text("EMPTY")],
                        loading: () => [const Text("EMPTY")]),
                  )
                ],
              );
            }, error: (error, _) {
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

  List<Widget> listFeedbacks(List feedbacks) {
    return feedbacks.isNotEmpty
        ? feedbacks
            .map((cmt) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: CommentWidget(comment: cmt),
                ))
            .toList()
        : [const Text("EMPTY")];
  }
}
