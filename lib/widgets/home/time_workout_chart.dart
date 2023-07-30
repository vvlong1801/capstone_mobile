import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:user_side_final_project/models/analysis_data.dart';

// ignore: must_be_immutable
class _BarChart extends StatelessWidget {
  List<TimeInDay> data;
  _BarChart(this.data);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  double _timeToMinutes(String timeString) {
    List<String> timeParts = timeString.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    double totalMinutes = (hours * 60 + minutes).toDouble();
    return totalMinutes;
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (data[value.toInt()].day) {
      case 1:
        text = 'Mn';
        break;
      case 2:
        text = 'Te';
        break;
      case 3:
        text = 'Wd';
        break;
      case 4:
        text = 'Tu';
        break;
      case 5:
        text = 'Fr';
        break;
      case 6:
        text = 'St';
        break;
      case 0:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.deepPurple,
          Colors.purpleAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        for (int i = 0; i < data.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: _timeToMinutes(data[i].totalDuration!),
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ),
      ];
}

// ignore: must_be_immutable
class TimeWorkoutChart extends StatefulWidget {
  List<TimeInDay> data;
  TimeWorkoutChart({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => TimeWorkoutChartState();
}

class TimeWorkoutChartState extends State<TimeWorkoutChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(widget.data),
    );
  }
}
