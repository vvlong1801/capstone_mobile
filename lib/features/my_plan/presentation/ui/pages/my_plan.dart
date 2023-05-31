import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/base/widgets/bottom_navigation_widget.dart';
// import 'package:user_side_final_project/base/controller/app_bar_controller.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/widgets/challenge_card.dart';

class MyPlanPage extends ConsumerWidget {
  const MyPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(
                          text: 'Plan List',
                        ),
                        Tab(
                          text: 'Bookmark',
                        )
                      ]),
                      Expanded(
                        child: TabBarView(children: [
                          ListView(
                            children: const [
                              ChallengeCard(),
                              ChallengeCard(),
                              ChallengeCard(),
                              ChallengeCard(),
                              ChallengeCard(),
                            ],
                          ),
                          Container(
                            color: Colors.blue,
                            child: const Center(
                              child: Text('tab 2'),
                            ),
                          ),
                        ]),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
