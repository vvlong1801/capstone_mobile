import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/base/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/features/explore/presentation/ui/widgets/personal_trainer_card.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/widgets/challenge_card.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
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
            SizedBox(
              height: 14,
            ),
            Row(
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
            SizedBox(
              height: 8,
            ),
            Container(
              height: 140,
              child: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PersonalTrainerCard(),
                    PersonalTrainerCard(),
                    PersonalTrainerCard(),
                    PersonalTrainerCard(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
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
            Expanded(
              child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(tabs: [
                        Tab(text: "Recommend"),
                        Tab(text: "Popular"),
                        Tab(text: "Newest"),
                      ]),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          ListView(
                            children: [
                              ChallengeCard(),
                              ChallengeCard(),
                              ChallengeCard(),
                              ChallengeCard(),
                            ],
                          ),
                          ListView(
                            children: [ChallengeCard()],
                          ),
                          ListView(
                            children: [ChallengeCard()],
                          ),
                        ]),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
