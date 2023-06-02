import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';

class RestPage extends ConsumerStatefulWidget {
  const RestPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestPageState();
}

class _RestPageState extends ConsumerState<RestPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "REST",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black26),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "+20s",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(countDownRoute);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 30,
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
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next 2/5",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Text(
                    "Jumping",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              ),
              Text(
                "3 sets X 10 reps",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset("assets/images/challenge-2.jpeg"),
          )
        ],
      ),
    );
  }
}
