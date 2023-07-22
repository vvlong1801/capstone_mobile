import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/auth/auth_provider.dart';

class VerifyPage extends ConsumerWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(authController.notifier).emailRegister;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 200),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/email.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                email,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "We have sent to you an email",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                "Please check your email and click verify",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple)),
                onPressed: () {
                  GoRouter.of(context).goNamed(guestRoute);
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Go to Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
