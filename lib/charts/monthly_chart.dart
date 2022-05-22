import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';

import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  //final List<PricePoint> points;

  const LineChartWidget({Key? key}) : super(key: key);

  static List<FlSpot> createSampleData() {
    final List<FlSpot> data = [];

    MeterManager.getCurrentMeter().MonthlyUsage.forEach((value) {
      String month = value.split(';')[0];
      String sum = value.split(';')[1];

      data.add(FlSpot(double.parse(month), double.parse(sum)));
    });
    return data;
  }

  static List<Color> gradientColors = [
    const Color(0xfff54242),
    Color.fromARGB(61, 255, 164, 164),
  ];
  static List<Color> gradientColors2 = [
    Color.fromARGB(255, 0, 240, 80),
    Color.fromARGB(255, 25, 185, 60),
  ];
  static List<FlSpot> createSampleData1() {
    final List<FlSpot> data = [];

    MeterManager.getCurrentMeter().MonthlyGeneration.forEach((value) {
      String month = value.split(';')[0];
      String sum = value.split(';')[1];

      data.add(FlSpot(double.parse(month), double.parse(sum)));
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
                bottomTitles: _bottomTitles,
                leftTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  checkToShowTitle: (double minValue,
                      double maxValue,
                      SideTitles sideTitles,
                      double appliedInterval,
                      double value) {
                    if (value == maxValue) return false;
                    return true;
                  },
                ),
                topTitles: SideTitles(showTitles: false),
                rightTitles: SideTitles(showTitles: false),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: createSampleData(),
                  colors: [Colors.pink],
                  isCurved: false,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
                LineChartBarData(
                  spots: createSampleData1(),
                  colors: [Colors.green],
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors2
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
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

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      reservedSize: 22,
      margin: 10,
      interval: 1,
      getTextStyles: (context, value) => const TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return 'Sty';
          case 2:
            return 'Lut';
          case 3:
            return 'Mar';
          case 4:
            return 'Kwi';
          case 5:
            return 'Maj';
          case 6:
            return 'Cze';
          case 7:
            return 'Lip';

          case 8:
            return 'Sie';
          case 9:
            return 'Wrz';
          case 10:
            return 'Paź';
          case 11:
            return 'Lis';
          case 12:
            return 'Gru';
        }
        return '';
      },
    );
