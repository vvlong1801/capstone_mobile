import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/challenge.dart';
import 'package:user_side_final_project/widgets/common/tag_widget.dart';

class ChallengeCard extends ConsumerWidget {
  final Challenge challenge;

  const ChallengeCard(
      {super.key,
      required this.challenge,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(detailChallengeRoute,
            pathParameters: {'id': challenge.id.toString()},
            queryParameters: {"showJoinButton": "show"});
      },
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                challenge.mainImage!.url,
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
                      challenge.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (challenge.level != null) TagWidget(text: challenge.level!),
                      if (challenge.phasesCount! > 1)
                        TagWidget(text: '${challenge.phasesCount} phases'),
                      if (challenge.totalSessions.isNotEmpty)
                        TagWidget(text: '${challenge.totalSessions} days'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(challenge.tags.length,
                        (index) => TagWidget(text: challenge.tags[index].name)),
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
