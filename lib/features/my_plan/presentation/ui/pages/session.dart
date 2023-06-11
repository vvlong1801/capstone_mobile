import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';

class SessionPage extends ConsumerWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                    alignment: Alignment.center,
                    height: 100,
                    color: Colors.deepPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "82",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "KCAL",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                    alignment: Alignment.center,
                    height: 100,
                    color: Colors.deepPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "82",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "KCAL",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                    alignment: Alignment.center,
                    height: 100,
                    color: Colors.deepPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "82",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "KCAL",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Exercises",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 4,
                ),
                Text("(5)")
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      GoRouter.of(context).pushNamed(detailExerciseRoute);
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Squash"),
                    subtitle: Text("5 sets, 10 reps"),
                    trailing: Icon(Icons.arrow_right_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Squash"),
                    subtitle: Text("5 sets, 10 reps"),
                    trailing: Icon(Icons.arrow_right_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Squash"),
                    subtitle: Text("5 sets, 10 reps"),
                    trailing: Icon(Icons.arrow_right_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Squash"),
                    subtitle: Text("5 sets, 10 reps"),
                    trailing: Icon(Icons.arrow_right_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/challenge-2.jpeg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text("Squash"),
                    subtitle: Text("5 sets, 10 reps"),
                    trailing: Icon(Icons.arrow_right_rounded),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            GoRouter.of(context).goNamed(readyRoute);
          },
          backgroundColor: Colors.deepPurple,
          label: Container(
              width: MediaQuery.of(context).size.width * 0.9 - 28,
              alignment: Alignment.center,
              child: Text(
                "Start",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
    );
  }
}
