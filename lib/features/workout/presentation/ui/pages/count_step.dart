import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/widgets/workout_app_bar_widget.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/features/workout/presentation/ui/widgets/workout_bottom.dart';

class CountStepPage extends ConsumerStatefulWidget {
  const CountStepPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountStepPageState();
}

class _CountStepPageState extends ConsumerState<CountStepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WorkoutAppBarWidget(),
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
                    "assets/images/challenge-2.jpeg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ]),
              Column(
                children: [
                  Text(
                    "SQUASH",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "3 sets X 10 reps",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(restRoute);
                          },
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 100,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 50,
                      )
                    ],
                  ),
                ],
              ),
              WorkoutBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
