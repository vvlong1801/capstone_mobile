import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/providers/explore/controllers/personal_trainer_controller.dart';
import 'package:user_side_final_project/widgets/explore/personal_trainer_card.dart';
import 'package:user_side_final_project/widgets/explore/challenge_card.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  final scrollChallengeController = ScrollController();
  late AsyncValue listPersonalTrainer;

  @override
  void initState() {
    scrollChallengeController.addListener(_scrollChallengeListener);
    debugPrint("init state explore");
    ref.read(exploreController.notifier).getChallenges();
    listPersonalTrainer = ref.refresh(listPersonalTrainerProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listChallenges = ref.watch(exploreController);
    listPersonalTrainer = ref.watch(listPersonalTrainerProvider);
    debugPrint("build explore");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
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
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(listPTRoute);
                  },
                  child: Flex(
                    direction: Axis.horizontal,
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
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            listPersonalTrainer.when(data: (data) {
              return SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: generateListPersonalTrainer(data),
                ),
              );
            }, error: (error, _) {
              return Text(error.toString());
            }, loading: () {
              return const Center(
                  child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator()));
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flex(direction: Axis.horizontal, children: [
                  const Text(
                    "Challenges",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                      onPressed: () {
                        ref.read(exploreController.notifier).getChallenges();
                      },
                      icon: const Icon(Icons.refresh_outlined))
                ]),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pushNamed(listChallenge);
                  },
                  child: Flex(
                    direction: Axis.horizontal,
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
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              child: listChallenges.when(
                  data: (data) {
                    return ListView.builder(
                      controller: scrollChallengeController,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ChallengeCard(
                          challenge: data[index],
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
      ref.read(exploreController.notifier).getChallenges();
    }
  }

  List<Widget> generateListPersonalTrainer(List listPT) {
    return listPT.map((pt) => PersonalTrainerCard(pt: pt)).toList();
  }
}
