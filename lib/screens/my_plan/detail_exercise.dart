import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/session_controller.dart';
import 'package:user_side_final_project/utils/index.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailExercisePage extends ConsumerStatefulWidget {
  final int index;

  DetailExercisePage({super.key, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailExercisePageState();
}

class _DetailExercisePageState extends ConsumerState<DetailExercisePage> {
  late YoutubePlayerController _youtubeController;
  @override
  void dispose() {
    super.dispose();
    _youtubeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = ref.watch(sessionExerciseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Exercise"),
      ),
      body: SafeArea(
          child: exercise.when(data: (value) {
        String firstTabTitle;
        if (value.data.youtubeUrl != null) {
          firstTabTitle = "video";
          _youtubeController = YoutubePlayerController(
              initialVideoId: getYoutubeId(value.data.youtubeUrl!)!);
        } else {
          firstTabTitle = "image";
        }

        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1 / 3,
                child: DefaultTabController(
                    length: 2,
                    initialIndex: 1,
                    child: Column(
                      children: [
                        TabBar(tabs: [
                          Tab(text: firstTabTitle),
                          const Tab(
                            text: "Animation",
                          )
                        ]),
                        const SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            firstTabTitle == "video"
                                ? YoutubePlayerBuilder(
                                    player: YoutubePlayer(
                                        controller: _youtubeController),
                                    builder: (context, player) {
                                      return Column(children: [player]);
                                    })
                                : Image.network(value.image!.url),
                            // Image.asset("assets/images/challenge-2.jpeg",),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(value.data.gif!.url)),
                          ]),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          children: [
                        TextSpan(
                          text: value.name!,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                " (${value.requirement} ${value.requirementUnit})",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))
                      ]))
                  // InkWell(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return SizedBox(
                  //             height: 800,
                  //             width: MediaQuery.of(context).size.width,
                  //             child: Container(
                  //               padding: EdgeInsets.only(
                  //                   left: 14, right: 14, top: 20),
                  //               child: Column(
                  //                 children: [
                  //                   Text(
                  //                     "Alternative Exercise",
                  //                     style: TextStyle(
                  //                         fontSize: 22,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                   Divider(),
                  //                   Expanded(
                  //                       child: ListView(
                  //                     children: [
                  //                       ListTile(
                  //                         leading: ClipRRect(
                  //                           borderRadius:
                  //                               BorderRadius.circular(8),
                  //                           child: Image.asset(
                  //                             "assets/images/challenge-2.jpeg",
                  //                             width: 60,
                  //                             height: 60,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                         title: Text("Exercise X"),
                  //                         subtitle: Text("dsfafasfa"),
                  //                         trailing: Icon(
                  //                           Icons.check_circle_rounded,
                  //                           size: 32,
                  //                         ),
                  //                       ),
                  //                       ListTile(
                  //                         leading: ClipRRect(
                  //                           borderRadius:
                  //                               BorderRadius.circular(8),
                  //                           child: Image.asset(
                  //                             "assets/images/challenge-2.jpeg",
                  //                             width: 60,
                  //                             height: 60,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                         title: Text("Exercise X"),
                  //                         subtitle: Text("dsfafasfa"),
                  //                         trailing: Icon(
                  //                           Icons.check_circle_rounded,
                  //                           size: 32,
                  //                         ),
                  //                       ),
                  //                       ListTile(
                  //                         leading: ClipRRect(
                  //                           borderRadius:
                  //                               BorderRadius.circular(8),
                  //                           child: Image.asset(
                  //                             "assets/images/challenge-2.jpeg",
                  //                             width: 60,
                  //                             height: 60,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                         title: Text("Exercise X"),
                  //                         subtitle: Text("dsfafasfa"),
                  //                         trailing: Icon(
                  //                           Icons.check_circle_rounded,
                  //                           size: 32,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ))
                  //                 ],
                  //               ),
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   child: Icon(
                  //     Icons.change_circle_rounded,
                  //     color: Colors.deepPurple,
                  //     size: 32,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(value.data.description ?? ""),
              ))
            ],
          ),
        );
      }, error: (error, _) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        );
      })),
    );
  }
}
