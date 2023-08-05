import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';
import 'package:user_side_final_project/providers/explore/controllers/personal_trainer_controller.dart';

class PersonalTrainerTile extends ConsumerWidget {
  PersonalTrainer pt;
  PersonalTrainerTile({super.key, required this.pt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(detailPTRoute, pathParameters: {"id": pt.id.toString()});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
          height: 124,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    pt.user!.avatar!.url,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/PT.jpeg",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _PersonalTrainerDescription(
                    pt: pt,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  ref
                      .read(personalTrainerIdProvider.notifier)
                      .update((state) => pt.id!);
                  GoRouter.of(context).pushNamed(detailPTRoute,
                      pathParameters: {"id": pt.id.toString()});
                },
                icon: const Icon(Icons.chevron_right_rounded),
                iconSize: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonalTrainerDescription extends StatelessWidget {
  const _PersonalTrainerDescription({
    required this.pt,
  });

  final PersonalTrainer pt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pt.user!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBar.builder(
                initialRating: pt.rate?.toDouble() ?? 0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 14,
                onRatingUpdate: (rating) {},
                ignoreGestures: true,
                allowHalfRating: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                pt.certificateIssuer!.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Text("${pt.desiredSalary}"),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(Icons.monetization_on_outlined),
                ],
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flex(
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                const Icon(
                  Icons.groups,
                  color: Colors.black87,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${pt.members}",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            // Flex(direction: Axis.horizontal, children: [
            //   Icon(
            //     Icons.verified_rounded,
            //     color: Colors.green,
            //   ),
            //   SizedBox(
            //     width: 4,
            //   ),
            //   Text(
            //     '$verifiedAt',
            //     style: const TextStyle(
            //       fontSize: 16,
            //       color: Colors.black87,
            //     ),
            //   ),
            // ]),
          ],
        ),
      ],
    );
  }
}
