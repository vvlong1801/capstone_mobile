import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailExercisePage extends ConsumerStatefulWidget {
  const DetailExercisePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailExercisePageState();
}

class _DetailExercisePageState extends ConsumerState<DetailExercisePage> {
  YoutubePlayerController _youtubeController =
      YoutubePlayerController(initialVideoId: "lNQJNImBsKY");
  @override
  void dispose() {
    super.dispose();
    _youtubeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Tab(text: "Video"),
                      Tab(
                        text: "Animation",
                      )
                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        YoutubePlayerBuilder(
                            player:
                                YoutubePlayer(controller: _youtubeController),
                            builder: (context, player) {
                              return Column(children: [player]);
                            }),
                        // Image.asset("assets/images/challenge-2.jpeg",),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/images/challenge-2.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Exercise A",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 800,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 14, right: 14, top: 20),
                            child: Column(
                              children: [
                                Text(
                                  "Alternative Exercise",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                Expanded(
                                    child: ListView(
                                  children: [
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/challenge-2.jpeg",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text("Exercise X"),
                                      subtitle: Text("dsfafasfa"),
                                      trailing: Icon(
                                        Icons.check_circle_rounded,
                                        size: 32,
                                      ),
                                    ),
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/challenge-2.jpeg",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text("Exercise X"),
                                      subtitle: Text("dsfafasfa"),
                                      trailing: Icon(
                                        Icons.check_circle_rounded,
                                        size: 32,
                                      ),
                                    ),
                                    ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/challenge-2.jpeg",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text("Exercise X"),
                                      subtitle: Text("dsfafasfa"),
                                      trailing: Icon(
                                        Icons.check_circle_rounded,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Icon(
                  Icons.change_circle_rounded,
                  color: Colors.deepPurple,
                  size: 32,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/challenge-2.jpeg",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/challenge-2.jpeg",
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Divider(),
                ListTile(
                  leading: Text(
                    "1",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  title: RichText(
                    text: TextSpan(
                        text:
                            "sfhjakdhsgahfjkalfhlhagladhgljhadgljhagjlahgjlahgjldghjgdhajgdshgdjsaghdskgjsdhgjkdghdskjghdsjkghgjkdghdjksghskjgdhgjkshgdjkghskhsjg",
                        style: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text(
                    "1",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  title: RichText(
                    text: TextSpan(
                        text:
                            "sfhjakdhsgahfjkalfhlhagladhgljhadgljhagjlahgjlahgjldghjgdhajgdshgdjsaghdskgjsdhgjkdghdskjghdsjkghgjkdghdjksghskjgdhgjkshgdjkghskhsjg",
                        style: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text(
                    "1",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  title: RichText(
                    text: TextSpan(
                        text:
                            "sfhjakdhsgahfjkalfhlhagladhgljhadgljhagjlahgjlahgjldghjgdhajgdshgdjsaghdskgjsdhgjkdghdskjghdsjkghgjkdghdjksghskjgdhgjkshgdjkghskhsjg",
                        style: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
