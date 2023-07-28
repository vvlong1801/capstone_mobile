import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';

class ScheduleWidget extends ConsumerStatefulWidget {
  int totalSession;
  int currentSession;

  int index;

  ScheduleWidget(
      {super.key,
      required this.totalSession,
      required this.currentSession,
      this.index = 0});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends ConsumerState<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
              children: List.generate(widget.totalSession, (index) {
                var num = index + 1;
                if (num < widget.currentSession) {
                  return completedSession(context, num);
                } else if (num == widget.currentSession) {
                  return doingSession(context, num);
                } else {
                  return disabledSession(num);
                }
              })),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${(((widget.currentSession - 1) / widget.totalSession * 100)).round()}%",
              textAlign: TextAlign.end,
            ),
          ],
        ),
        LinearProgressIndicator(
          value: ((widget.currentSession - 1) / widget.totalSession),
          minHeight: 14,
          color: Colors.green,
        )
      ],
    );
  }

  Widget completedSession(BuildContext context, number) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {
          ref.read(planController.notifier).sessionWorkoutIndex = number;
          GoRouter.of(context).pushNamed(sessionRoute, queryParameters: {
            'sessionIndex': (number - 1).toString(),
            'phaseIndex': widget.index.toString()
          });
        },
        child: Container(
          // width: 32,
          // height: 32,
          alignment: Alignment.center,
          child: Icon(
            Icons.check_rounded,
            size: 28,
            color: Colors.white,
          ),
          decoration: const BoxDecoration(color: Colors.green),
        ),
      ),
    );
  }

  Widget doingSession(BuildContext context, number) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {
          ref.read(planController.notifier).sessionWorkoutIndex = number;
          GoRouter.of(context).pushNamed(sessionRoute, queryParameters: {
            'sessionIndex': (number - 1).toString(),
            'phaseIndex': widget.index.toString()
          });
        },
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
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget disabledSession(number) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.black12),
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
// class ScheduleWidget extends ConsumerWidget {
//   int totalSession;
//   int currentSession;

//   int index;

//   ScheduleWidget(
//       {super.key,
//       required this.totalSession,
//       required this.currentSession,
//       this.index = 0});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Flexible(
//           child: GridView(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 6,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 1),
//               children: List.generate(totalSession, (index) {
//                 var num = index + 1;
//                 if (num < currentSession) {
//                   return completedSession(context, num);
//                 } else if (num == currentSession) {
//                   return doingSession(context, num);
//                 } else {
//                   return disabledSession(num);
//                 }
//               })),
//         ),
//         const SizedBox(
//           height: 14,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               "${(((currentSession - 1) / totalSession * 100)).round()}%",
//               textAlign: TextAlign.end,
//             ),
//           ],
//         ),
//         LinearProgressIndicator(
//           value: ((currentSession - 1) / totalSession),
//           minHeight: 14,
//           color: Colors.green,
//         )
//       ],
//     );
  
//   }

//   Widget completedSession(BuildContext context, number) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(90),
//       child: GestureDetector(
//         onTap: () {
          
//           GoRouter.of(context).pushNamed(sessionRoute, queryParameters: {
//             'sessionIndex': (number - 1).toString(),
//             'phaseIndex': index.toString()
//           });
//         },
//         child: Container(
//           // width: 32,
//           // height: 32,
//           alignment: Alignment.center,
//           child:  Icon(
//             Icons.check_rounded,
//             size: 28,
//             color: Colors.white,
//           ),
//           decoration: const BoxDecoration(color: Colors.green),
//         ),
//       ),
//     );
//   }

//   Widget doingSession(BuildContext context, number) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(90),
//       child: GestureDetector(
//         onTap: () {
//           GoRouter.of(context).pushNamed(sessionRoute, queryParameters: {
//             'sessionIndex': (number - 1).toString(),
//             'phaseIndex': index.toString()
//           });
//         },
//         child: Container(
//           // width: 32,
//           // height: 32,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.green,
//                 width: 4,
//               ),
//               borderRadius: BorderRadius.circular(90)),
//           child: Text(
//             number.toString(),
//             style: const TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget disabledSession(number) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(90),
//       child: GestureDetector(
//         onTap: () {},
//         child: Container(
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(color: Colors.black12),
//           child: Text(
//             number.toString(),
//             style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black38),
//           ),
//         ),
//       ),
//     );
//   }

// }
