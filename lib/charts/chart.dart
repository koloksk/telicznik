/// Line chart example
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/charts/text_symbol_render.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<LinearSales, int>> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),

      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList,
        animate: animate,
        behaviors: [
          charts.LinePointHighlighter(
            ////////////////////// notice ////////////////////////////
            symbolRenderer:
                TextSymbolRenderer(() => Random().nextInt(100).toString()),
            ////////////////////// notice ////////////////////////////
          ),
        ],
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final List<LinearSales> data = [];

    MeterManager.getCurrentMeter().MonthlyUsage.forEach((key, value) {
      if (key != "0") {
        data.add(new LinearSales(
            key, int.parse(double.parse(value).toStringAsFixed(0))));
      }
    });

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
