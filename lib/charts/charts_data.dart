import 'package:fl_chart/fl_chart.dart';

import '../Meters/MeterManager.dart';

List<FlSpot> createDailyUsage(String time) {
  final List<FlSpot> data = [];

  MeterManager.getCurrentMeter().DailyUsage.forEach((value) {
    String month = value.split(';')[0].toString().split("-")[1];
    String year = value.split(';')[0].toString().split("-")[0];
    String ym = "$year-$month";

    if (ym == time) {
      String day = (value.split(';')[0]).toString().split("-")[2];
      String sum = value.split(';')[1];
      //print(hour + ":" + sum);
      data.add(FlSpot(double.parse(day), double.parse(sum)));
    }
  });
  return data;
}

List<FlSpot> createDailyGeneration(String time) {
  final List<FlSpot> data = [];

  MeterManager.getCurrentMeter().DailyGeneration.forEach((value) {
    String month = value.split(';')[0].toString().split("-")[1];
    String year = value.split(';')[0].toString().split("-")[0];
    String ym = "$year-$month";

    if (ym == time) {
      String day = (value.split(';')[0]).toString().split("-")[2];
      String sum = value.split(';')[1];
      //print(hour + ":" + sum);
      data.add(FlSpot(double.parse(day), double.parse(sum)));
    }
  });
  return data;
}

List<FlSpot> createHourlyUsage(String time) {
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

List<FlSpot> createHourlyGeneration(String time) {
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

List<FlSpot> createMonthlyUsage(String time) {
  final List<FlSpot> data = [];

  MeterManager.getCurrentMeter().MonthlyUsage.forEach((value) {
    String year = value.split(';')[1];
    if (year == time) {
      String month = value.split(';')[0];
      String sum = value.split(';')[2];

      data.add(FlSpot(double.parse(month), double.parse(sum)));
    }
  });
  return data;
}

List<FlSpot> createMonthlyGeneration(String time) {
  final List<FlSpot> data = [];

  MeterManager.getCurrentMeter().MonthlyGeneration.forEach((value) {
    String year = value.split(';')[1];
    if (year == time) {
      String month = value.split(';')[0];
      String sum = value.split(';')[2];

      data.add(FlSpot(double.parse(month), double.parse(sum)));
    }
  });
  return data;
}
