import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';

class ScheduleWidget extends ConsumerWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      children: [
        completedSession(context),
        doingSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
        disabledSession(),
      ],
    );
    // return Container(
    //   child: Text("schedule component"),
    // );
  }

  Widget completedSession(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).pushNamed(sessionRoute);
        },
        child: Container(
          // width: 32,
          // height: 32,
          alignment: Alignment.center,
          child: const Icon(
            Icons.check_rounded,
            size: 28,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(color: Colors.green),
        ),
      ),
    );
  }

  Widget doingSession() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          // width: 32,
          // height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(90)),
          child: const Text(
            "2",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget disabledSession() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          // width: 32,
          // height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.black12),
          child: const Text(
            "3",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ),
      ),
    );
  }
}
