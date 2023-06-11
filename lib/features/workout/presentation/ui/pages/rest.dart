import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/countdown_controller.dart';

class RestPage extends ConsumerStatefulWidget {
  const RestPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestPageState();
}

class _RestPageState extends ConsumerState<RestPage> {
  @override
  void initState() {
    super.initState();
    ref.read(restTimerController.notifier).run(
        context: context,
        redirect: () => GoRouter.of(context).goNamed(countDownRoute));
  }

  double? calcProgressValue(int max, int current) {
    return (max - current) / max;
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(restTimerController);
    final controller = ref.read(restTimerController.notifier);

    return Scaffold(
      appBar: WorkoutAppBarWidget(
        actionLeading: controller.pause,
        actionContinue: controller.run,
        actionExit: controller.dispose,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "REST",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.add(20);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black26),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "+20s",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        controller.dispose();
                        GoRouter.of(context).goNamed(countDownRoute);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 160,
                width: 160,
                child: Stack(fit: StackFit.expand, children: [
                  CircularProgressIndicator(
                    value: calcProgressValue(
                        ref.read(restTimerController.notifier).init, time),
                    color: Colors.deepPurple,
                    backgroundColor: Colors.black26,
                    strokeWidth: 14,
                  ),
                  Center(
                    child: Text(
                      "$time",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Next 2/5",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Text(
                        "Jumping",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  ),
                  Text(
                    "3 sets X 10 reps",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset("assets/images/challenge-2.jpeg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
