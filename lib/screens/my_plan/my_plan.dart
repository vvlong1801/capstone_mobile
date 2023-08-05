import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
// import 'package:user_side_final_project/providers/my_plan/controllers/plan_controller.dart';
import 'package:user_side_final_project/widgets/my_plan/plan_card.dart';

class MyPlanPage extends ConsumerStatefulWidget {
  const MyPlanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPlanPageState();
}

class _MyPlanPageState extends ConsumerState<MyPlanPage> {
  late AsyncValue listPlans;
  @override
  void initState() {
    listPlans = ref.refresh(listPlanProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listPlans = ref.watch(listPlanProvider);
    final otherPlans = ref.watch(doingPlansProvider);
    final completedPlans = ref.watch(completedPlansProvider);
    final firstPlan = ref.watch(firstPlanProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Plan",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "In Progress",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      // ref.read(planController.notifier).fetchPlans();
                      listPlans = ref.refresh(listPlanProvider);
                    },
                    icon: const Icon(Icons.refresh_outlined))
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            firstPlan.when(
              data: (data) {
                return PlanCard(
                  plan: data,
                );
              },
              error: (error, stackTrace) => const Text("NO PLAN"),
              loading: () => const Center(
                  child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator())),
            ),
            const SizedBox(
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
                          text: 'Other',
                        ),
                        Tab(
                          text: 'Completed',
                        )
                      ]),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          otherPlans.when(
                              data: (data) {
                                return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return PlanCard(
                                        plan: data[index],
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
                          completedPlans.when(data: (data) {
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return PlanCard(
                                    plan: data[index],
                                  );
                                });
                          }, error: (error, stackTrace) {
                            return Text(error.toString());
                          }, loading: () {
                            return const Center(
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator()));
                          }),
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
