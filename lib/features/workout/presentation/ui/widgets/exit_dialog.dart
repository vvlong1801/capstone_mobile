import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/audio_controller.dart';

class ExitWorkout extends ConsumerWidget {
  final Function? actionContinue;
  final Function? actionReset;
  final Function? actionExit;

  const ExitWorkout(
      {this.actionReset, this.actionExit, super.key, this.actionContinue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog.fullscreen(
        backgroundColor: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          actionContinue!.call();
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(230, 155, 39, 176)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 14)),
                            alignment: Alignment.centerLeft),
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(230, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 14)),
                            alignment: Alignment.centerLeft),
                        child: Text(
                          "Reset this exercise",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          ref.read(audioPlayerController.notifier).pause();
                          if (actionExit != null) {
                            actionExit!.call();
                          }
                          GoRouter.of(context).goNamed(myPlanRoute);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(230, 255, 255, 255)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 14)),
                            alignment: Alignment.centerLeft),
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
