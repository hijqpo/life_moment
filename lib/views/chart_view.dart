import 'package:flutter/material.dart';
import 'package:fcharts/fcharts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const data = [0.0, -0.2, -0.9, -0.5, 0.0, 0.5, 0.6, 0.9, 0.8, 1.2, 0.5, 0.0];
Widget _buildChart(){
  return Container(
    alignment: Alignment(0.0, 0.5),
    child: AspectRatio(
      aspectRatio: 4.0,
      child: new LineChart(
        lines: [
          new Sparkline(
            data: data,
            stroke: new PaintOptions.stroke(
              color: Colors.blue,
              strokeWidth: 2.0,
            ),
            marker: new MarkerOptions(
              paint: new PaintOptions.fill(color: Colors.blue),
            ),
          ),
        ],
      ),
    ),
  
  );
}
class ChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          //_buildCoverImage(screenSize),
          Text('Mood Progress'),
          _buildChart(),
          

        ],
      )
    );
  }
}
