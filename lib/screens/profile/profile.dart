import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/health/health_provider.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';
import 'package:user_side_final_project/providers/setting/invitation_controller.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    bool authorized = ref.watch(healthProvider).authorized;
    final profile = ref.watch(profileProvider);
    final invitations = ref.watch(listInvitationsProvider);
    print("authorized health data: $authorized");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      child: Center(
                        child: Text(
                          profile.name?.substring(0, 1) ?? "L",
                          style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${profile.name}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${profile.email}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 32,
                      ),
                      title: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      onTap: () {
                        GoRouter.of(context).pushNamed(reminderRoute);
                      },
                      leading: const Icon(
                        Icons.alarm_on_outlined,
                        size: 32,
                      ),
                      title: const Text(
                        "Setting reminder",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                        onTap: () {
                          GoRouter.of(context).pushNamed(invitationRoute);
                        },
                        leading: const Icon(
                          Icons.label_important_outline_rounded,
                          size: 32,
                        ),
                        title: const Text(
                          "Challenge Invitations",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        trailing: invitations.when(
                            data: (data) {
                              return data.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: Container(
                                          color: Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 4),
                                            child: Text(
                                              "${data.length}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : null;
                            },
                            error: (error, _) => null,
                            loading: () => null)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(8)),
                          child: Image.asset(
                              "assets/images/apple_health_icon.png"),
                        ),
                        title: const Text(
                          "Apple Health",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        trailing: Switch(
                          value: authorized,
                          onChanged: (value) {
                            print(value);
                            if (value) {
                              ref.read(healthProvider.notifier).authorize();
                            } else {
                              ref.read(healthProvider.notifier).unAuthorize();
                            }
                          },
                          activeColor: Colors.red,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      onTap: () {
                        GoRouter.of(context).goNamed(guestRoute);
                      },
                      leading: const Icon(
                        Icons.logout_outlined,
                        size: 32,
                        color: Colors.red,
                      ),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
