import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/layouts/widgets/bottom_navigation_widget.dart';
import 'package:user_side_final_project/models/analysis_data.dart';
import 'package:user_side_final_project/providers/insight/analysis_controller.dart';
import 'package:user_side_final_project/widgets/home/kcal_chart.dart';
import 'package:user_side_final_project/widgets/home/time_workout_chart.dart';

class InsightPage extends ConsumerStatefulWidget {
  const InsightPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InsightPageState();
}

class _InsightPageState extends ConsumerState<InsightPage> {
  late AsyncValue<AnalysisData> data;
  @override
  void initState() {
    data = ref.refresh(analysisData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ref.watch(analysisData);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Insight",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: data.when(data: (data) {
        print(data.timeInDay);
        var datasets = {
          for (var date in data.workoutDays!)
            DateTime(date.year, date.month, date.day): 3
        };
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: HeatMapCalendar(
                    flexible: true,
                    textColor: Colors.black87,
                    colorMode: ColorMode.color,
                    colorsets: const {
                      3: Colors.deepOrange,
                    },
                    datasets: datasets,
                    showColorTip: false,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                KcalChart(
                  data: data.calInDay!,
                ),
                const Text(
                  "Burned cal in week",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange),
                ),
                const SizedBox(
                  height: 40,
                ),
                TimeWorkoutChart(
                  data: data.timeInDay!,
                ),
                const Text(
                  "Times workout in week",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${data.totalTime}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "Time Workout",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${data.sessionCount}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "Session",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width:
                            MediaQuery.of(context).size.width * 1 / 3 - 28 / 3,
                        alignment: Alignment.center,
                        height: 100,
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${data.challengeCount}",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text(
                              "Challenge",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
        );
      }, error: (error, _) {
        return Center(child: Text(error.toString()));
      }, loading: () {
        return const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
        );
      }),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
