// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_meter/controllers/mood_api.dart';
import 'package:mood_meter/models/mood_data.dart';
import 'package:mood_meter/models/user.dart';
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

  refresh(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Graph'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/new_mood', arguments: {'refresh_graph': refresh});
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: constraints.maxWidth > constraints.maxHeight ? const EdgeInsets.only(right: 75) : const EdgeInsets.only(bottom: 75),
              child: FutureBuilder<List<User>>(
                future: MoodAPI.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const CircularProgressIndicator(color: Colors.blue,);
                  } else {
                    List<User> users = snapshot.data!;
                    return SfCartesianChart(
                      primaryXAxis: DateTimeAxis(
                        title: AxisTitle(text: 'dd/mm/yyyy'),
                        name: 'Date',
                        dateFormat: DateFormat("dd/MM/yyyy - HH:mm:ss"),
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
                        name: 'Mood',
                        // Setting the minimum and maximum values of the y-axis
                        minimum: 0,
                        maximum: 10,
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
                
                      series: <LineSeries<MoodData, DateTime>>[] + users.map((user) => LineSeries<MoodData, DateTime>(
                          name: user.name,
                          dataSource: user.moods,
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
                      ).toList()
                    );
                  }
                }
              ),
            );
          }
        ),
      ),
    );
  }
}