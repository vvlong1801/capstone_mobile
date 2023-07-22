import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/services/challenge_service.dart';
import 'package:user_side_final_project/utils/index.dart';
import 'package:user_side_final_project/widgets/common/comment_widget.dart';
import 'package:user_side_final_project/widgets/common/stat_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class DetailInvitationPage extends ConsumerStatefulWidget {
  late int? challengId;

  DetailInvitationPage({super.key, required this.challengId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailInvitationPageState();
}

class _DetailInvitationPageState extends ConsumerState<DetailInvitationPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> onAcceptInvitation(BuildContext context) async {
    ref
        .read(challengeServiceProvider)
        .acceptInvitation(widget.challengId)
        .then((value) => {
              GoRouter.of(context)
                  .goNamed(joinChallengeSuccessRoute, queryParameters: {
                'redirectRoute': invitationRoute,
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final challenge = ref.watch(showChallengeProvider(widget.challengId));
    debugPrint("build");
    return challenge.when(
        data: (data) {
          _youtubeController = YoutubePlayerController(
              initialVideoId: getYoutubeId(data.youtubeUrl!)!);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
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
                            value: "5",
                          ),
                          StatWidget(
                            label: "Hours",
                            value: "0",
                          ),
                          StatWidget(
                            label: "Star",
                            value: "4.5",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
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
                    const SizedBox(height: 14),
                    YoutubePlayerBuilder(
                        player: YoutubePlayer(controller: _youtubeController),
                        builder: (context, player) {
                          return player;
                        }),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(data.description ?? ""),
                    const SizedBox(
                      height: 14,
                    ),
                    const Row(
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
                    const SizedBox(
                      height: 8,
                    ),
                    const CommentWidget(username: "long", content: "goof"),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => onAcceptInvitation(context),
                backgroundColor: Colors.deepPurple,
                label: Container(
                    width: MediaQuery.of(context).size.width * 0.9 - 28,
                    alignment: Alignment.center,
                    child: const Text(
                      "Accept",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text("Not Found"),
            ),
        loading: () => const Center(
              child: SizedBox(
                  width: 60, height: 60, child: CircularProgressIndicator()),
            ));
  }
}
