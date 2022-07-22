import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';

import 'package:fl_chart/fl_chart.dart';

import 'charts_style.dart';

class hourly_chart extends StatelessWidget {
  //final List<PricePoint> points;
  final String time;

  const hourly_chart({Key? key, required this.time}) : super(key: key);
  List<FlSpot> createSampleData() {
    print(time);

    final List<FlSpot> data = [];

    MeterManager.getCurrentMeter().HourlyUsage.forEach((value) {
      String day = value.split(';')[0];
      if (day == time) {
        String hour = value.split(';')[1];
        String sum = value.split(';')[2];
        //print(hour + ":" + sum);
        data.add(FlSpot(double.parse(hour), double.parse(sum)));
      }
    });
    return data;
  }

  List<FlSpot> createSampleData1() {
    final List<FlSpot> data = [];

    MeterManager.getCurrentMeter().HourlyGeneration.forEach((value) {
      String day = value.split(';')[0];
      if (day == time) {
        String hour = value.split(';')[1];
        String sum = value.split(';')[2];
        //print(hour + ":" + sum);
        data.add(FlSpot(double.parse(hour), double.parse(sum)));
      }
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, right: 20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
            ),
          ],
        ),
        child: AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(
                  border:
                      const Border(bottom: BorderSide(), left: BorderSide())),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    // checkToShowTitle: (double minValue,
                    //     double maxValue,
                    //     SideTitles sideTitles,
                    //     double appliedInterval,
                    //     double value) {
                    //   if (value == maxValue) return false;
                    //   return true;
                    // },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: createSampleData(),
                  color: chartstyles.usage,
                  isCurved: false,
                  belowBarData: BarAreaData(
                    show: true,
                    color: chartstyles.usage,
                  ),
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
                LineChartBarData(
                  spots: createSampleData1(),
                  color: chartstyles.generation,
                  belowBarData: BarAreaData(
                    show: true,
                    color: chartstyles.generation,
                  ),
                  isCurved: false,
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                    maxContentWidth: 100,
                    tooltipBgColor: Colors.orange,
                    getTooltipItems: (touchedSpots) {
                      print(touchedSpots);
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        return LineTooltipItem(
                            '${touchedSpot.y.toStringAsFixed(2)} kWh',
                            textStyle);
                      }).toList();
                    }),
                handleBuiltInTouches: true,
                getTouchLineStart: (data, index) => 0,
              ),
            ),
          ),
        ));
  }
}
