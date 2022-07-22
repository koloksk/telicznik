import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class chartstyles {
  static Color usage = const Color.fromARGB(100, 255, 0, 0);
  static Color generation = const Color.fromARGB(100, 30, 255, 0);
  static List<Color> gradientColors = [
    const Color(0xfff54242),
    const Color.fromARGB(61, 255, 164, 164),
  ];
  static List<Color> gradientColors2 = [
    const Color.fromARGB(255, 0, 240, 80),
    const Color.fromARGB(255, 25, 185, 60),
  ];

  static LineTouchData spotstyle = LineTouchData(
    touchTooltipData: LineTouchTooltipData(
        maxContentWidth: 120,
        tooltipBgColor: const Color.fromARGB(255, 255, 255, 255),
        getTooltipItems: (touchedSpots) {
          print(touchedSpots);
          return touchedSpots.map((LineBarSpot touchedSpot) {
            final textStyle = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: touchedSpot.bar.color?.withAlpha(255));
            return LineTooltipItem(
                '${getVarName(textStyle)} ${touchedSpot.y.toStringAsFixed(2)} ',
                textStyle,
                children: [
                  const TextSpan(
                    text: 'kWh',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ]);
          }).toList();
        }),
    handleBuiltInTouches: true,
    getTouchLineStart: (data, index) => 0,
  );
}

String getVarName(TextStyle style) {
  if (style.color == chartstyles.generation.withAlpha(255)) {
    return 'G:';
  } else {
    return 'U:';
  }
}
