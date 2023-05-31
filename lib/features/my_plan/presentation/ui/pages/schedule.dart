import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/features/my_plan/presentation/ui/widgets/schedule_widget.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Challenge A',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(),
                  child: ScheduleWidget(),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "50%",
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 14,
                      color: Colors.purple,
                    )
                  ],
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
              width: MediaQuery.of(context).size.width * 0.9 - 28,
              alignment: Alignment.center,
              child: Text(
                "Start",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ))),
    );
  }
}
