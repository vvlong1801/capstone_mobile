import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/my_plan_controller.dart';
import 'package:user_side_final_project/utils/index.dart';
import 'package:user_side_final_project/widgets/common/comment_widget.dart';
import 'package:user_side_final_project/widgets/common/stat_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class DetailChallengePage extends ConsumerStatefulWidget {
  late int? challengId;

  DetailChallengePage({super.key, required this.challengId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailChallengePageState();
}

class _DetailChallengePageState extends ConsumerState<DetailChallengePage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
  }

  void onJoinChallenge(BuildContext context) async {
    final approved =
        await ref.watch(joinChallengeProvider(widget.challengId).future);
    if (approved) {
      GoRouter.of(context).goNamed(joinChallengeSuccessRoute);
    } else {
      GoRouter.of(context).goNamed(joinChallengeWaitingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final challenge = ref.watch(showChallengeProvider(widget.challengId));

    return challenge.when(
        data: (data) {
          _youtubeController = YoutubePlayerController(
              initialVideoId: getYoutubeId(data.youtubeUrl!)!);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatWidget(
                            label: "Member",
                            value: "100",
                          ),
                          StatWidget(
                            label: "Hours",
                            value: "1000+",
                          ),
                          StatWidget(
                            label: "Star",
                            value: "4.5",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Challenge A",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bookmark_border_rounded,
                              size: 28,
                            ))
                      ],
                    ),
                    SizedBox(height: 14),
                    YoutubePlayerBuilder(
                        player: YoutubePlayer(controller: _youtubeController),
                        builder: (context, player) {
                          return Column(children: [player]);
                        }),
                    SizedBox(
                      height: 14,
                    ),
                    challenge.when(
                      data: (data) {
                        return Text(data.description ?? "");
                      },
                      error: (Object error, StackTrace stackTrace) {
                        return Text("");
                      },
                      loading: () {
                        return Text("");
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Feedbacks",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "See More",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.deepPurple,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CommentWidget(username: "long", content: "goof"),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => onJoinChallenge(context),
                backgroundColor: Colors.deepPurple,
                label: Container(
                    width: MediaQuery.of(context).size.width * 0.9 - 28,
                    alignment: Alignment.center,
                    child: Text(
                      "Join",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
          );
        },
        error: (error, stackTrace) => Center(
              child: Text("Not Found"),
            ),
        loading: () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 60, height: 60, child: CircularProgressIndicator()),
              ],
            ));
  }
}
