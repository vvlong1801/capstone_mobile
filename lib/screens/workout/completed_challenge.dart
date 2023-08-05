import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/core/router/name_route.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_test_controller.dart';

class CompletedChallengePage extends ConsumerStatefulWidget {
  const CompletedChallengePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedChallengePageState();
}

class _CompletedChallengePageState
    extends ConsumerState<CompletedChallengePage> {
  late int? rateValue;

  @override
  void initState() {
    rateValue = 0;
    super.initState();
  }

  void onClickHome() async {
    if (rateValue != null && rateValue! > 0) {
      debugPrint("post rate $rateValue");
      ref.read(rateChallengeFuture(rateValue!));
    }
    GoRouter.of(context).goNamed(myPlanRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset("assets/images/challenge.avif"),
          const SizedBox(
            height: 30,
          ),
          Text(
            "COMPLETE",
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 32,
                fontWeight: FontWeight.w900),
          ),
          Text(
            "CHALLENGE",
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 40,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 14,
          ),
          const Center(
            child: Text(
              "Please rating for challenge",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RatingBar.builder(
              initialRating: 4,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 60,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {
                setState(() {
                  rateValue = rating.toInt();
                  print(rateValue);
                });
              }),
          const SizedBox(
            height: 160,
          ),
          if (rateValue != null && rateValue! > 0)
            TextButton(
                onPressed: () => onClickHome(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)))),
                child: const InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "HOME",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )),
        ]),
      )),
    );
  }
}
