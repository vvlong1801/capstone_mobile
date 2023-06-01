import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/base/base_page.dart';
import 'package:user_side_final_project/features/explore/presentation/ui/pages/explore.dart';
import 'package:user_side_final_project/features/home/presentation/ui/pages/home.dart';
import 'package:user_side_final_project/features/messages/presentation/ui/pages/message.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/pages/detail_exercise.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/pages/my_plan.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/pages/schedule.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/pages/session.dart';
import 'package:user_side_final_project/features/setting/presentation/ui/pages/setting.dart';

import 'name_route.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavBarNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_navbar');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/my-plan/detail_exercise',
      routes: [
        ShellRoute(
            navigatorKey: _shellNavBarNavigatorKey,
            builder: (context, state, child) {
              return BasePage(key: state.pageKey, child: child);
            },
            routes: [
              GoRoute(
                path: '/',
                name: homeRoute,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: HomePage());
                },
              ),
              GoRoute(
                path: '/my-plan',
                name: myPlanRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MyPlanPage()),
                routes: [
                  GoRoute(
                    path: 'schedule',
                    name: scheduleRoute,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: SchedulePage(
                        key: state.pageKey,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'session',
                    name: sessionRoute,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: SessionPage(
                        key: state.pageKey,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'detail_exercise',
                    name: detailExerciseRoute,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: DetailExercisePage(
                        key: state.pageKey,
                      ),
                    ),
                  ),
                ],
              ),
              // GoRoute(path: '/workout', routes: [
              //   GoRoute(
              //     path: 'ready',
              //     name: readyWorkoutRoute,
              //     pageBuilder: (context, state) => NoTransitionPage(
              //         child: ReadyWorkoutPage(
              //       key: state.pageKey,
              //     )),
              //   ),
              //   GoRoute(
              //     path: 'count-down',
              //     name: countDownRoute,
              //     pageBuilder: (context, state) => NoTransitionPage(
              //         child: CountDownPage(
              //       key: state.pageKey,
              //     )),
              //   ),
              //   GoRoute(
              //     path: 'count-step',
              //     name: countStepRoute,
              //     pageBuilder: (context, state) => NoTransitionPage(
              //         child: CountStepPage(
              //       key: state.pageKey,
              //     )),
              //   ),
              //   GoRoute(
              //     path: 'rest-time',
              //     name: restTimeRoute,
              //     pageBuilder: (context, state) => NoTransitionPage(
              //         child: RestTimePage(
              //       key: state.pageKey,
              //     )),
              //   ),
              //   GoRoute(
              //     path: 'completed',
              //     name: completedWorkoutRout,
              //     pageBuilder: (context, state) => NoTransitionPage(
              //         child: CompletedWorkoutPage(
              //       key: state.pageKey,
              //     )),
              //   ),
              // ]),
              GoRoute(
                path: '/explore',
                name: exploreRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ExplorePage()),
              ),
              GoRoute(
                path: '/message',
                name: messageRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MessagePage()),
              ),
              GoRoute(
                path: '/setting',
                name: settingRoute,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SettingPage()),
              ),
            ]),
      ]);
});
