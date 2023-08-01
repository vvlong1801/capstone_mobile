import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/explore_controller.dart';
import 'package:user_side_final_project/widgets/explore/challenge_card.dart';

class ListChallengePage extends ConsumerStatefulWidget {
  ListChallengePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListChallengePageState();
}

class _ListChallengePageState extends ConsumerState<ListChallengePage> {
  @override
  Widget build(BuildContext context) {
    final listChallenge = ref.watch(exploreController);
    return Scaffold(
      appBar: AppBar(
        title: Text("List challenges"),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(14),
              child: listChallenge.when(data: (data) {
                return ListView(
                  children: generateListChallenge(data),
                );
              }, error: (error, _) {
                Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }))),
    );
  }

  List<Widget> generateListChallenge(List listChallenge) {
    return listChallenge.map((c) => ChallengeCard(challenge: c)).toList();
  }
}
