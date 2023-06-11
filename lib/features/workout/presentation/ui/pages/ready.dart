import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/audio_controller.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/countdown_controller.dart';

class ReadyPage extends ConsumerStatefulWidget {
  const ReadyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadyPageState();
}

class _ReadyPageState extends ConsumerState<ReadyPage> {
  @override
  void initState() {
    super.initState();

    ref.read(readyTimerController.notifier).run(
        context: context,
        redirect: () => GoRouter.of(context).pushNamed(countStepRoute));
    ref.read(audioPlayerController.notifier).play();
  }

  double? calcProgressValue(int max, int current) {
    return (max - current) / max;
  }

  @override
  void dispose() {
    ref.read(readyTimerController.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(readyTimerController);
    final controller = ref.read(readyTimerController.notifier);

    return Scaffold(
      appBar: WorkoutAppBarWidget(
        actionLeading: controller.pause,
        actionContinue: controller.run,
        actionExit: controller.reset,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/challenge-2.jpeg",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "Get Ready!",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple),
                ),
              ),
              const Center(
                child: Text(
                  "jumping",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 160,
                width: 160,
                child: Stack(fit: StackFit.expand, children: [
                  CircularProgressIndicator(
                    value: calcProgressValue(controller.init, time),
                    color: Colors.deepPurple,
                    backgroundColor: Colors.black26,
                    strokeWidth: 14,
                  ),
                  Center(
                    child: Text(
                      "$time",
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  controller.reset();
                  GoRouter.of(context).goNamed(countStepRoute);
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 14))),
                child: const Center(
                  child: Text(
                    "Start Over",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
