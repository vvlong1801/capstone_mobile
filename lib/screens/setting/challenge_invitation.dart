import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/setting/invitation_controller.dart';
import 'package:user_side_final_project/widgets/setting/invitation_card.dart';

class ChallengeInvitationPage extends ConsumerStatefulWidget {
  const ChallengeInvitationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChallengeInvitationPageState();
}

class _ChallengeInvitationPageState
    extends ConsumerState<ChallengeInvitationPage> {
  late AsyncValue invitations;
  @override
  initState() {
    super.initState();
    invitations = ref.refresh(listInvitationsProvider);
    debugPrint("initState");
  }

  @override
  Widget build(BuildContext context) {
    invitations = ref.watch(listInvitationsProvider);
    return Padding(
        padding: const EdgeInsets.all(14.0),
        child: invitations.when(data: (data) {
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InvitationCard(
                  id: data[index].id,
                  name: data[index].name,
                  level: data[index].level,
                  image: data[index].mainImage,
                  tags: data[index].tags,
                  phasesCount: data[index].phasesCount,
                  totalSessions: data[index].totalSessions,
                );
              });
        }, error: ((error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        }), loading: () {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        }));
  }
}
