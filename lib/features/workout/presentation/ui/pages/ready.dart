import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';

class ReadyPage extends ConsumerStatefulWidget {
  const ReadyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadyPageState();
}

class _ReadyPageState extends ConsumerState<ReadyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/challenge-2.jpeg",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Get Ready!",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
            ),
            Center(
              child: Text(
                "jumping",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 160,
              width: 160,
              child: Stack(fit: StackFit.expand, children: [
                CircularProgressIndicator(
                  value: 0.5,
                  color: Colors.deepPurple,
                  backgroundColor: Colors.black26,
                  strokeWidth: 14,
                  semanticsLabel: "5",
                  semanticsValue: "5",
                ),
                Center(
                  child: Text(
                    "5",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 28,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).pushNamed(countStepRoute);
          },
          child: Center(
            child: Text(
              "Start Over",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
