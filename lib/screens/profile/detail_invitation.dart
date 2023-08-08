import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/models/media.dart';
import 'package:user_side_final_project/models/message.dart';
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
          debugPrint(data.youtubeUrl);
          if (data.youtubeUrl != null) {
            _youtubeController = YoutubePlayerController(
                initialVideoId: getYoutubeId(data.youtubeUrl!)!);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Detail Invitation"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "(${data.numRate})",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            RatingBar.builder(
                              initialRating: data.rate ?? 0,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: 24,
                              onRatingUpdate: (rating) {},
                              ignoreGestures: true,
                              allowHalfRating: true,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    data.youtubeUrl != null
                        ? YoutubePlayerBuilder(
                            player:
                                YoutubePlayer(controller: _youtubeController),
                            builder: (context, player) {
                              return player;
                            })
                        : carouselImageWidget(data.images!),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(data.description ?? ""),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Comments",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(listCommentRoute,
                                pathParameters: {
                                  "id": widget.challengId.toString()
                                });
                          },
                          child: const Flex(
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
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    data.comments.isNotEmpty
                        ? Column(
                            children: listComments(data.comments),
                          )
                        : const Center(
                            child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("No Comment"),
                          ))
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

  List<Widget> listComments(List<Message> comments) {
    return comments
        .map((cmt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CommentWidget(comment: cmt),
            ))
        .toList();
  }

  Widget carouselImageWidget(List<Media> images) {
    return CarouselSlider(
        items: images
            .map((img) => Container(
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      img.url,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions());
  }
}
