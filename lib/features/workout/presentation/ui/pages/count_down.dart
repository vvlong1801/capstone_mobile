import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/features/workout/presentation/controller/countdown_exercise_controller.dart';
import 'package:user_side_final_project/features/workout/presentation/ui/widgets/workout_bottom.dart';

class CountDownPage extends ConsumerStatefulWidget {
  const CountDownPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountDownPageState();
}

class _CountDownPageState extends ConsumerState<CountDownPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    ref.read(countdownExerciseController.notifier).run(
        context: context,
        redirect: () => GoRouter.of(context).goNamed(congratulationRoute));

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        --ref.read(readyCountDownProvider.notifier).state;
        if (ref.watch(readyCountDownProvider) > 0) {
          _animationController.reset();
          _animationController.forward();
        } else {
          ref.read(readyCountDownProvider.notifier).dispose();
          _animationController.dispose();
        }
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final int num = ref.watch(readyCountDownProvider);
    final int seconds = ref.watch(countdownExerciseController);
    final controller = ref.read(countdownExerciseController.notifier);
    final iconController = ref.read(iconCountDownProvider.notifier);
    final iconCountDown = ref.watch(iconCountDownProvider);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/exercise_2.gif",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: num > 0
                            ? Center(
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Text(
                                      "$num",
                                      style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ])
              ]),
              Column(
                children: [
                  const Text(
                    "SQUASH",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    "00:$seconds",
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepPurple),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iconCountDown == "running") {
                            iconController.state = "stop";
                            controller.pause();
                          } else {
                            iconController.state = "running";
                            controller.run(
                                context: context,
                                redirect: () => GoRouter.of(context)
                                    .goNamed(congratulationRoute));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: iconCountDown == "running"
                              ? Icon(
                                  Icons.pause_circle_rounded,
                                  size: 100,
                                  color: Colors.deepPurple,
                                )
                              : Icon(
                                  Icons.stop_circle_rounded,
                                  size: 100,
                                  color: Colors.deepPurple,
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pause();
                          GoRouter.of(context).goNamed(congratulationRoute);
                        },
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              WorkoutBottom(
                  actionBeforeShowModal: controller.pause,
                  actionAfterShowModal: () => controller.run(
                      context: context,
                      redirect: () =>
                          GoRouter.of(context).goNamed(congratulationRoute))),
            ],
          ),
        ),
      ),
    );
  }
}
