import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/my_plan_controller.dart';
import 'package:user_side_final_project/widgets/my_plan/plan_card.dart';

class MyPlanPage extends ConsumerWidget {
  const MyPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listPlans = ref.watch(planController);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "In Progress",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14,
            ),
            listPlans.when(
              data: (data) {
                return PlanCard(
                  id: data[0].id,
                  name: data[0].challenge.name,
                  level: data[0].challenge.level,
                  image: data[0].challenge.mainImage,
                  tags: data[0].challenge.tags,
                  phasesCount: data[0].challenge.phasesCount,
                  totalSessions: data[0].challenge.totalSessions,
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const Center(
                  child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator())),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(
                          text: 'All',
                        ),
                        Tab(
                          text: 'Completed',
                        )
                      ]),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          listPlans.when(
                              data: (data) {
                                return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return PlanCard(
                                        id: data[index].id,
                                        name: data[index].challenge.name,
                                        level: data[index].challenge.level,
                                        image: data[index].challenge.mainImage,
                                        tags: data[index].challenge.tags,
                                        phasesCount: data[index].challenge.phasesCount,
                                        totalSessions:
                                            data[index].challenge.totalSessions,
                                      );
                                    });
                              },
                              error: ((error, stackTrace) {
                                return Text(error.toString());
                              }),
                              loading: () => const Center(
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator()))),
                          Container(
                            color: Colors.blue,
                            child: const Center(
                              child: Text('tab 2'),
                            ),
                          ),
                        ]),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
