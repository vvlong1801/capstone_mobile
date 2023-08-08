import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/explore/controllers/challenge_controller.dart';
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
    // final listChallenge = ref.watch(exploreController);
    final listChallenge = ref.watch(filteredChallenges);
    // final choosedTags = ref.watch(choosedTagsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("List challenges"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(searchChallengeRoute);
                },
                icon: Icon(
                  Icons.search_rounded,
                  size: 32,
                )),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(14),
              child: listChallenge.when(data: (data) {
                return Column(
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: generateTags(listTags),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView(
                        children: generateListChallenge(data),
                      ),
                    ),
                  ],
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

  List<Widget> generateTags(List tags) {
    var choosedTags = ref.watch(choosedTagsProvider);
    return tags.map((tag) {
      var existed = choosedTags.contains(tag);
      return InkWell(
        onTap: () {
          setState(() {
            if (existed) {
              ref.read(choosedTagsProvider.notifier).update((state) {
                state = choosedTags.where((element) => element != tag).toList();
                print(state);
                return state;
              });
            } else {
              ref
                  .read(choosedTagsProvider.notifier)
                  .update((state) => state = [...state, tag]);
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: existed ? Colors.deepPurple : Colors.black12,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              tag,
              style: TextStyle(color: existed ? Colors.white : Colors.black),
            ),
          ),
        ),
      );
    }).toList();
  }
}
