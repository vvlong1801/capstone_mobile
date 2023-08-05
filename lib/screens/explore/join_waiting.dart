import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';

class JoinWaitingPage extends ConsumerWidget {
  const JoinWaitingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          const SizedBox(
            height: 140,
          ),
          Image.asset(
            "assets/images/sended_request.png",
            width: 300,
          ),
          const Center(
            child: Text(
              "YOUR REQUEST HAS BEEN SENT",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
              onPressed: () => GoRouter.of(context).goNamed(exploreRoute),
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: Text(
                  "HOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    )));
  }
}
