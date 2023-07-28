import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/plan.dart';
import 'package:user_side_final_project/widgets/common/tag_widget.dart';

class PlanCard extends ConsumerWidget {
  final Plan plan;

  const PlanCard({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(scheduleRoute,
            pathParameters: {'id': plan.id.toString()});
      },
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                plan.challenge.mainImage!.url,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/challenge-2.jpeg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 144,
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 1.0,
                height: 144,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: 144.0,
              decoration: const BoxDecoration(
                  color: Color(0x4D14181B),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      plan.challenge.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (plan.challenge.level != null)
                        TagWidget(text: plan.challenge.level!),
                      if (plan.challenge.phasesCount! > 1)
                        TagWidget(text: '${plan.challenge.phasesCount} phases'),
                      if (plan.challenge.totalSessions.isNotEmpty)
                        TagWidget(text: '${plan.challenge.totalSessions} days'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(
                        plan.challenge.tags.length,
                        (index) =>
                            TagWidget(text: plan.challenge.tags[index].name)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
