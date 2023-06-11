import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/audio_controller.dart';
import 'package:user_side_final_project/features/workout/presentation/ui/widgets/select_music.dart';

// ignore: must_be_immutable
class WorkoutBottom extends ConsumerWidget {
  Function? actionBeforeShowModal;
  Function? actionAfterShowModal;
  WorkoutBottom(
      {super.key, this.actionBeforeShowModal, this.actionAfterShowModal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioPlayerController);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (actionBeforeShowModal != null) {
                  actionBeforeShowModal!.call();
                }
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SelectMusicBottomSheet();
                    }).then((value) {
                  if (actionAfterShowModal != null) {
                    actionAfterShowModal!.call();
                  }
                });
              },
              child: Icon(
                Icons.music_note_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "next",
                  style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Jumping",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (audioState == AudioPlayerState.mute) {
                  ref.read(audioPlayerController.notifier).unMute();
                } else {
                  ref.read(audioPlayerController.notifier).mute();
                }
              },
              child: audioState == AudioPlayerState.mute
                  ? Icon(
                      Icons.volume_off_rounded,
                      size: 24,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.volume_up_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
