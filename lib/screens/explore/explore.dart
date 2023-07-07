import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/services/challenge_service.dart';
import 'package:user_side_final_project/widgets/explore/personal_trainer_card.dart';
import 'package:user_side_final_project/widgets/explore/challenge_card.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final scrollChallengeController = ScrollController();

  @override
  void initState() {
    scrollChallengeController.addListener(_scrollChallengeListener);
    super.initState();
    // ref.watch(challengeServiceProvider).fetchChallenges();
  }

  @override
  Widget build(BuildContext context) {
    final listChallenges = ref.watch(listChallengeProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Morning, Long',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.front_hand_rounded,
                  color: Colors.amber,
                )
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Personal Trainer",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple),
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
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  PersonalTrainerCard(),
                  PersonalTrainerCard(),
                  PersonalTrainerCard(),
                  PersonalTrainerCard(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Challenges",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.deepPurple,
                    )
                  ],
                )
              ],
            ),
            DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(text: "Recommend"),
                        Tab(text: "Popular"),
                        Tab(text: "Newest"),
                      ]),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          listChallenges.when(
                              data: (data) {
                                return ListView.builder(
                                  controller: scrollChallengeController,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return ChallengeCard(
                                      id: data[index].id,
                                      name: data[index].name,
                                      level: data[index].level,
                                      image: data[index].mainImage,
                                      tags: data[index].tags,
                                      phasesCount: data[index].phasesCount,
                                      totalSessions: data[index].totalSessions,
                                    );
                                  },
                                );
                              },
                              error: ((error, stackTrace) {
                                return Text(error.toString());
                              }),
                              loading: () => const Center(
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator()))),
                          ListView(
                            children: const [],
                          ),
                          ListView(
                            children: const [],
                          ),
                        ]),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }

  void _scrollChallengeListener() {
    if (scrollChallengeController.position.pixels ==
            scrollChallengeController.position.maxScrollExtent ||
        scrollChallengeController.position.pixels ==
            scrollChallengeController.position.minScrollExtent) {
      ref.read(challengeServiceProvider).fetchChallenges();
    }
  }
}

// class ExplorePage extends ConsumerWidget {
//   const ExplorePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     print("explore");

//   }
// }
