// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:flutter/material.dart';
import 'package:mood_meter/models/mood_data.dart';
import 'package:mood_meter/utils/datetime_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MoodGraph extends StatefulWidget {
  const MoodGraph({ Key? key }) : super(key: key);

  @override
  State<MoodGraph> createState() => _MoodGraphState();
}

class _MoodGraphState extends State<MoodGraph> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Graph'),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            title: AxisTitle(text: 'dd/mm/yyyy'),
            name: 'Mood',
            dateFormat: DateFormat("dd/MM/yyyy"),
            axisLabelFormatter: (AxisLabelRenderDetails args) {
              late String text;
              print(args.value);
              text = DateTime.fromMillisecondsSinceEpoch(args.value.toInt()).dateString;
              return ChartAxisLabel(text, args.textStyle);
            },
          ),
          primaryYAxis: NumericAxis(
            rangePadding: ChartRangePadding.additional,
            // Assigned a name for the y-axis for customization purposes
            name: 'Date'
          ),
          // Enable legend
          legend: Legend(
            isVisible: true,
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          // Enable tooltip
          tooltipBehavior: _tooltipBehavior,

          series: <LineSeries<MoodData, DateTime>>[
            LineSeries<MoodData, DateTime>(
              name: "Bastien",
              dataSource:  <MoodData>[
                MoodData(date: DateTime(2022, 04, 28), mood: 5),
                MoodData(date: DateTime(2022, 04, 30), mood: 7),
                MoodData(date: DateTime(2022, 05, 01), mood: 8),
                MoodData(date: DateTime(2022, 05, 02), mood: 3),
                MoodData(date: DateTime(2022, 05, 04), mood: 9),
                MoodData(date: DateTime(2022, 05, 05), mood: 10),
              ],
              xValueMapper: (MoodData data, _) => data.date,
              yValueMapper: (MoodData data, _) => data.mood,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            LineSeries<MoodData, DateTime>(
              name: "Chien",
              dataSource:  <MoodData>[
                MoodData(date: DateTime(2022, 04, 29), mood: 8),
                MoodData(date: DateTime(2022, 04, 30), mood: 5),
                MoodData(date: DateTime(2022, 05, 01), mood: 6),
                MoodData(date: DateTime(2022, 05, 02), mood: 5),
                MoodData(date: DateTime(2022, 05, 03), mood: 4),
                MoodData(date: DateTime(2022, 05, 05), mood: 10),
              ],
              xValueMapper: (MoodData data, _) => data.date,
              yValueMapper: (MoodData data, _) => data.mood,
              // Enable data label
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}