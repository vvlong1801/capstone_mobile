import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/providers/workout/controller/audio_controller.dart';

class SelectMusicBottomSheet extends ConsumerWidget {
  SelectMusicBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 800,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: 20),
        child: Column(
          children: [
            Text(
              "Select Music",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    ref.read(audioPlayerController.notifier).setMusic("audio");
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/challenge-2.jpeg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Music A"),
                  subtitle: Text("01:27"),
                  trailing: Icon(
                    Icons.check_circle_rounded,
                    size: 32,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  onTap: () {
                    ref
                        .read(audioPlayerController.notifier)
                        .setMusic("audio_2");
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/challenge-2.jpeg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Music A"),
                  subtitle: Text("01:27"),
                  trailing: Icon(
                    Icons.check_circle_rounded,
                    size: 32,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/challenge-2.jpeg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Music A"),
                  subtitle: Text("01:27"),
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
  }
}
