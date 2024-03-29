import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/base_page.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_age.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_goal.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_height.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_level.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_gender.dart';
import 'package:user_side_final_project/screens/auth/first_login/choose_weight.dart';
import 'package:user_side_final_project/screens/auth/first_login/fill_profile.dart';

import 'package:user_side_final_project/screens/auth/guest.dart';
import 'package:user_side_final_project/screens/auth/login.dart';
import 'package:user_side_final_project/screens/auth/register.dart';
import 'package:user_side_final_project/screens/auth/verify.dart';
import 'package:user_side_final_project/screens/explore/detail_challenge.dart';
import 'package:user_side_final_project/screens/explore/detail_pt.dart';
import 'package:user_side_final_project/screens/explore/explore.dart';
import 'package:user_side_final_project/screens/explore/join_success.dart';
import 'package:user_side_final_project/screens/explore/join_waiting.dart';
import 'package:user_side_final_project/screens/explore/list_challenge.dart';
import 'package:user_side_final_project/screens/explore/list_comment.dart';
import 'package:user_side_final_project/screens/explore/list_pt.dart';
import 'package:user_side_final_project/screens/explore/search_challenge.dart';
import 'package:user_side_final_project/screens/home/insight.dart';
import 'package:user_side_final_project/screens/messages/message.dart';
import 'package:user_side_final_project/screens/my_plan/comment.dart';
import 'package:user_side_final_project/screens/my_plan/detail_exercise.dart';
import 'package:user_side_final_project/screens/my_plan/my_plan.dart';
import 'package:user_side_final_project/screens/my_plan/schedule.dart';
import 'package:user_side_final_project/screens/my_plan/session.dart';
import 'package:user_side_final_project/screens/profile/challenge_invitation.dart';
import 'package:user_side_final_project/screens/profile/detail_invitation.dart';
import 'package:user_side_final_project/screens/profile/reminder_setting.dart';
import 'package:user_side_final_project/screens/profile/profile.dart';
import 'package:user_side_final_project/screens/workout/completed_challenge.dart';
import 'package:user_side_final_project/screens/workout/congratulation.dart';
import 'package:user_side_final_project/screens/workout/count_down_workout.dart';
import 'package:user_side_final_project/screens/workout/count_step_workout.dart';
import 'package:user_side_final_project/screens/workout/ready.dart';
import 'package:user_side_final_project/screens/workout/rest.dart';

import 'name_route.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'base');
// final GlobalKey<NavigatorState> _workoutNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'workout');

final goRouterProvider = Provider<GoRouter>((ref) {
  // bool isAuthenticated = ref.read(authController.notifier).isAuthenticated;
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/guest',
      routes: [
        GoRoute(
          path: "/guest",
          name: guestRoute,
          builder: (context, state) => GuestPage(),
        ),
        GoRoute(
          path: "/login",
          name: loginRoute,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: "/register",
          name: registerRoute,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: "/verify",
          name: verifyRoute,
          builder: (context, state) => VerifyPage(),
        ),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) {
              return BasePage(key: state.pageKey, child: child);
            },
            routes: [
              GoRoute(
                path: '/',
                name: homeRoute,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: InsightPage());
                },
              ),
              GoRoute(
                path: '/my-plan',
                name: myPlanRoute,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: MyPlanPage());
                },
                routes: [
                  GoRoute(
                    path: 'schedule/:id',
                    name: scheduleRoute,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: SchedulePage(
                          key: state.pageKey,
                          planId: int.parse(state.pathParameters["id"]!)),
                    ),
                  ),
                  GoRoute(
                    path: 'challenges/:id/comments',
                    name: commentRoute,
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: CommentPage(
                      challengeId: int.parse(state.pathParameters["id"]!),
                    )),
                  ),
                  GoRoute(
                    path: 'session',
                    name: sessionRoute,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                          child: SessionPage(
                        key: state.pageKey,
                        sessionIndex:
                            int.parse(state.queryParameters["sessionIndex"]!),
                        phaseIndex:
                            int.parse(state.queryParameters["phaseIndex"]!),
                      ));
                    },
                  ),
                  GoRoute(
                      path: 'detail_exercise/:index',
                      name: detailExerciseRoute,
                      pageBuilder: (context, state) {
                        return NoTransitionPage(
                          child: DetailExercisePage(
                            key: state.pageKey,
                            index: int.parse(state.pathParameters["index"]!),
                          ),
                        );
                      }),
                ],
              ),
              GoRoute(
                  path: '/explore',
                  name: exploreRoute,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: ExplorePage(
                      key: state.pageKey,
                    ));
                  },
                  routes: [
                    GoRoute(
                        path: 'detail-challenge/:id',
                        name: detailChallengeRoute,
                        pageBuilder: (context, state) {
                          var show =
                              state.queryParameters["showJoinButton"] == "show"
                                  ? true
                                  : false;
                          return NoTransitionPage(
                              child: DetailChallengePage(
                            challengId: int.parse(
                              state.pathParameters["id"]!,
                            ),
                            showJoinButton: show,
                          ));
                        }),
                    GoRoute(
                        path: 'personal-trainers',
                        name: listPTRoute,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: ListPersonalTrainerPage(),
                          );
                        }),
                    GoRoute(
                        path: 'personal-trainers/:id',
                        name: detailPTRoute,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: DetailPersonalTrainerPage(
                              id: int.parse(state.pathParameters["id"]!),
                            ),
                          );
                        }),
                    GoRoute(
                        path: 'challenges',
                        name: listChallenge,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: ListChallengePage(),
                          );
                        }),
                    GoRoute(
                        path: 'challenges/search',
                        name: searchChallengeRoute,
                        pageBuilder: (context, state) {
                          return NoTransitionPage(
                            child: SearchChallengePage(),
                          );
                        }),
                    GoRoute(
                      path: 'challenges/:id/comments',
                      name: listCommentRoute,
                      pageBuilder: (context, state) => NoTransitionPage(
                          child: ListCommentPage(
                        challengeId: int.parse(state.pathParameters["id"]!),
                      )),
                    ),
                  ]),
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
                  routes: [
                    GoRoute(
                      path: 'reminder',
                      name: reminderRoute,
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: ReminderSettingPage()),
                    ),
                    GoRoute(
                      path: 'invitation',
                      name: invitationRoute,
                      pageBuilder: (context, state) =>
                          NoTransitionPage(child: ChallengeInvitationPage()),
                    ),
                    GoRoute(
                      path: 'invitation/:id',
                      name: detailInvitationRoute,
                      pageBuilder: (context, state) => NoTransitionPage(
                          child: DetailInvitationPage(
                        challengId: int.parse(state.pathParameters["id"]!),
                      )),
                    ),
                  ]),
            ]),
        GoRoute(
            path: '/workout/ready',
            name: readyRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: ReadyPage(
                key: state.pageKey,
              ));
            }),
        GoRoute(
          path: '/workout/count-down',
          name: countDownRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: CountDownPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/workout/count-step',
          name: countStepRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: CountStepPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/workout/rest-time',
          name: restRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: RestPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/workout/congratulation',
          name: congratulationRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: CongratulationPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/workout/completed_challenge',
          name: completedChallengeRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: CompletedChallengePage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
            path: '/explore/join_challenge/success',
            name: joinChallengeSuccessRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  child: JoinSuccessPage(
                key: state.pageKey,
                redirectRoute:
                    state.queryParameters['redirectRoute'] ?? exploreRoute,
              ));
            }),
        GoRoute(
          path: '/explore/join_challenge/waiting',
          name: joinChallengeWaitingRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: JoinWaitingPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/gender',
          name: chooseGenderRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseGenderPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/age',
          name: chooseAgeRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseAgePage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/weight',
          name: chooseWeightRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseWeightPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/height',
          name: chooseHeightRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseHeightPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/goal',
          name: chooseGoalRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseGoalPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/level',
          name: chooseLevelRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ChooseLevelPage(
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/question/profile',
          name: fillProfileRoute,
          pageBuilder: (context, state) => NoTransitionPage(
              child: FillProfilePage(
            key: state.pageKey,
          )),
        ),
      ]);
});
