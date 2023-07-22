import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/media.dart';
import 'package:user_side_final_project/models/tag.dart';
import 'package:user_side_final_project/widgets/common/tag_widget.dart';

class InvitationCard extends ConsumerWidget {
  final int id;
  final Media? image;

  final String? level;

  final String name;

  final List<Tag> tags;

  final int phasesCount;
  final String? totalSessions;

  const InvitationCard(
      {super.key,
      required this.name,
      this.level,
      required this.tags,
      this.image,
      this.totalSessions,
      required this.id,
      this.phasesCount = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(detailInvitationRoute,
            pathParameters: {'id': id.toString()});
      },
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image!.url,
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
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (level != null) TagWidget(text: level!),
                      if (phasesCount > 1)
                        TagWidget(text: '$phasesCount phases'),
                      if (totalSessions != null)
                        TagWidget(text: '$totalSessions days'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(tags.length,
                        (index) => TagWidget(text: tags[index].name)),
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
