import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';

// ignore: must_be_immutable
class PersonalTrainerCard extends ConsumerWidget {
  PersonalTrainer pt;
  PersonalTrainerCard({
    super.key,
    required this.pt,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .pushNamed(detailPTRoute, pathParameters: {"id": pt.id.toString()});
      },
      child: Card(
        margin: EdgeInsets.only(right: 10),
        elevation: 0,
        color: Colors.amber,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // child: Image.asset(
              //   "assets/images/$image",
              //   width: 150,
              //   height: 150,
              //   fit: BoxFit.cover,
              // ),
              child: Image.network(
                pt.user!.avatar!.url,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/PT.jpeg",
                  fit: BoxFit.cover,
                  width: 200,
                  height: 150,
                ),
                fit: BoxFit.cover,
                width: 200,
                height: 150,
              ),
            ),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0x4D14181B)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pt.user!.name!,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(0),
                        color: Color(0x32FFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              pt.techniques![0].name,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.all(0),
                        color: Color(0x32FFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: Text(
                              pt.techniques![1].name,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
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
