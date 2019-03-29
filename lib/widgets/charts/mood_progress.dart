import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:life_moment/data_structures/mood_data.dart';

class MoodProgress extends StatefulWidget {

  MoodProgress(this.data);
  final List<MoodChartData> data;

  @override
  _MoodProgressState createState() => _MoodProgressState();
}

class _MoodProgressState extends State<MoodProgress> {

  bool _animated = true;

  @override
  Widget build(BuildContext context) {

    // final data = [
    //   new MoodChartData(DateTime.utc(2019, 2, 1), 0, 70),
    //   new MoodChartData(DateTime.utc(2019, 2, 2), 1, 50),
    //   new MoodChartData(DateTime.utc(2019, 2, 3), 2, 50),
    //   new MoodChartData(DateTime.utc(2019, 2, 4), 3, 50),
    //   new MoodChartData(DateTime.utc(2019, 2, 5), 4, 50),
    //   new MoodChartData(DateTime.utc(2019, 2, 6), 2, 50),
    //   new MoodChartData(DateTime.utc(2019, 2, 7), 3, 50),
    // ];

    final List<MoodChartData> data = widget.data;
    debugPrint('$data');

    if (data == null || data.length == 0){
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No Mood Progress',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16
          )
        ),
      );
    }


    List<Series<MoodChartData, DateTime>> chartData = [

      Series<MoodChartData, DateTime>(
        id: 'Mood',
        colorFn: (_, __) {
          switch(_.moodType){
            case 0:
              return MaterialPalette.red.shadeDefault;
            case 1:
              return MaterialPalette.red.shadeDefault;
            case 2:
              return MaterialPalette.green.shadeDefault;
            case 3:
              return MaterialPalette.yellow.shadeDefault;
            case 4:
              return MaterialPalette.yellow.shadeDefault;
            default:
              return MaterialPalette.black;
          }
        },
        domainFn: (MoodChartData mood, _) => mood.time,
        measureFn: (MoodChartData mood, _) => mood.moodType,
        data: data,
        fillColorFn: (_, __) {

          switch(_.moodType){
            case 0:
              return MaterialPalette.red.shadeDefault;
            case 1:
              return MaterialPalette.red.shadeDefault;
            case 2:
              return MaterialPalette.green.shadeDefault;
            case 3:
              return MaterialPalette.yellow.shadeDefault;
            case 4:
              return MaterialPalette.yellow.shadeDefault;
            default:
              return MaterialPalette.black;

          }
        },
        radiusPxFn: (MoodChartData mood, __) => 1 + (mood.moodIntensity / 18)
      )
    ];
    
    return Container(
      
      padding: const EdgeInsets.all(12.0),
      height: 130,
      child: TimeSeriesChart(
        chartData, 
        animate: _animated, 
        defaultRenderer: LineRendererConfig(includePoints: true),
        domainAxis: DateTimeAxisSpec(
          showAxisLine: true, 
          tickFormatterSpec: AutoDateTimeTickFormatterSpec(
            day: TimeFormatterSpec(
              format: 'dd',
              transitionFormat: 'dd MM'
            )
          )
        ),
      )
    );
  }
}

