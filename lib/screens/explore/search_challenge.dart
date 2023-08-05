import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/providers/explore/controllers/challenge_controller.dart';
import 'package:user_side_final_project/widgets/explore/challenge_card.dart';

class SearchChallengePage extends ConsumerStatefulWidget {
  const SearchChallengePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchChallengePageState();
}

class _SearchChallengePageState extends ConsumerState<SearchChallengePage> {
  late TextEditingController searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listChallenges = ref.watch(searchedChallenges);
    print(listChallenges);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: searchTextController,
          decoration: const InputDecoration(
              hintText: "Search ...",
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.black54),
          onChanged: (value) {
            ref
                .read(searchTextProvider.notifier)
                .update((state) => state = value);
          },
        ),
        actions: [
          TextButton(
              onPressed: () => GoRouter.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 14),
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(14),
              child: listChallenges.when(data: (data) {
                return ListView(
                  children: generateChallenges(data),
                );
              }, error: (error, _) {
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                return Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }))),
    );
  }

  List<Widget> generateChallenges(List? listChallenges) {
    return listChallenges?.map((c) => ChallengeCard(challenge: c)).toList() ??
        [];
  }
}
