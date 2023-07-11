import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/profile_controller.dart';

class FillProfilePage extends ConsumerStatefulWidget {
  const FillProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FillProfilePageState();
}

class _FillProfilePageState extends ConsumerState<FillProfilePage> {
  final TextEditingController _fullnameInputController =
      TextEditingController();
  final TextEditingController _phoneNumberInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
        child: Center(
          child: Column(
            children: [
              const Column(
                children: [
                  Text(
                    "Fill Your Profile",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "To give you a better experience and results",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    "we need to know your gender",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: const Icon(
                              Icons.person_2_rounded,
                              size: 120,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 28,
                              color: Colors.black87,
                            ),
                          ),
                          bottom: 2,
                          right: 2,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        controller: _fullnameInputController,
                        decoration:
                            const InputDecoration(labelText: "Fullname"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: TextField(
                        controller: _phoneNumberInputController,
                        decoration:
                            const InputDecoration(labelText: "Phone Number"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade200)),
                        onPressed: () {
                          ref.read(profileProvider.notifier).updateProfile();
                          GoRouter.of(context).goNamed(exploreRoute);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 18),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.deepPurple)),
                        onPressed: () {
                          ref
                              .read(profileProvider.notifier)
                              .setPhoneNumber(_phoneNumberInputController.text);
                          ref.read(profileProvider.notifier).updateProfile();
                          GoRouter.of(context).goNamed(exploreRoute);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Start",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
