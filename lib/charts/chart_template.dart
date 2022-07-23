import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:telicznik/charts/charts_style.dart';

class chart_template extends StatelessWidget {
  //final List<PricePoint> points;
  final String time;
  final List<FlSpot> datausage;
  final List<FlSpot> datageneration;
  const chart_template(
      {Key? key,
      required this.time,
      required this.datausage,
      required this.datageneration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, right: 20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 30,
              color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
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
                      //     double value)
                      // {
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
                    spots: datausage,
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
                    spots: datageneration,
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
                lineTouchData: chartstyles.spotstyle),
          ),
        ));
  }
}
