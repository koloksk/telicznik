import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/charts/daily_chart.dart';
import 'package:telicznik/charts/monthly_chart.dart';
import 'package:telicznik/charts/hourly_chart.dart';
import 'package:telicznik/drawer.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../appbar.dart';

class ChartsPage extends StatefulWidget {
  static String tag = 'charts-page';

  @override
  _ChartsPage createState() => _ChartsPage();
}

class _ChartsPage extends State<ChartsPage> {
  DateTime selectedDay = DateTime.parse(MeterManager.getCurrentMeter().DateTo);
  DateTime selectedMonth = DateTime.now();
  DateTime selectedYear = DateTime.now();

  Future<void> _selectMonth(BuildContext context) async {
    final picked = await showMonthYearPicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime.parse(MeterManager.getCurrentMeter().DateFrom),
      lastDate: DateTime.parse(MeterManager.getCurrentMeter().DateTo),
      initialMonthYearPickerMode: MonthYearPickerMode.month,
      //initialEntryMode: DatePickerEntryMode.calendarOnly
    );
    setState(() {
      selectedMonth = picked!;
    });
  }

  Future<void> _selectDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDay,
        firstDate: DateTime.parse(MeterManager.getCurrentMeter().DateFrom),
        lastDate: DateTime.parse(MeterManager.getCurrentMeter().DateTo),
        initialDatePickerMode: DatePickerMode.day,
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    setState(() {
      selectedDay = picked!;
      print(
          "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}");
    });
  }

  _selectYear(BuildContext context) async {
    return YearPicker(
      firstDate: DateTime.parse(MeterManager.getCurrentMeter().DateFrom),
      lastDate: DateTime.parse(MeterManager.getCurrentMeter().DateTo),
      initialDate: DateTime.now(),
      // save the selected date to _selectedDate DateTime variable.
      // It's used to set the previous selected date when
      // re-showing the dialog.
      selectedDate: selectedYear,
      onChanged: (DateTime dateTime) {
        // close the dialog when year is selected.
        Navigator.pop(context);

        // Do something with the dateTime selected.
        // Remember that you need to use dateTime.year to get the year
      },
    );
  }

  String tryb = "d";

  @override
  Widget build(BuildContext context) {
    final buttons = Container(
      height: 60,
      //width: MediaQuery.of(context).size.width,
      //padding: EdgeInsets.all(10.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onBackground),
                  backgroundColor: tryb == "h"
                      ? MaterialStateProperty.all<Color>(Colors.pink.shade100)
                      : MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    tryb = "h";
                  });
                },
                child: Text('Godzinny'),
              ),
              SizedBox(width: 10),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onBackground),
                  backgroundColor: tryb == "d"
                      ? MaterialStateProperty.all<Color>(Colors.pink.shade100)
                      : MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    tryb = "d";
                  });
                },
                child: Text('Dzienny'),
              ),
              SizedBox(width: 10),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onBackground),
                  backgroundColor: tryb == "m"
                      ? MaterialStateProperty.all<Color>(Colors.pink.shade100)
                      : MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    tryb = "m";
                  });
                },
                child: Text('Miesięczny'),
              ),
              SizedBox(width: 10),
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.onBackground),
                    backgroundColor: tryb == "z"
                        ? MaterialStateProperty.all<Color>(Colors.pink.shade100)
                        : MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                onPressed: () {
                  setState(() {
                    tryb = "z";
                  });
                },
                child: Text('Zakres'),
              )
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [SizedBox(height: 40), buttons, GetChart()],
      ),
      drawer: PublicDrawer(),
      appBar: PublicAppBar(),
    );
  }

  GetChart() {
    if (tryb == "h") {
      return hourly();
    }
    if (tryb == "d") {
      return daily();
    }
    if (tryb == "m") {
      return monthly();
    }
  }

  daily() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            _selectMonth(context);
          },
          child: Text('Wybierz miesiąc'),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "dzienny " + selectedMonth.toString(),
            style:
                TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        daily_chart(
            time:
                "${selectedMonth.year}-${selectedMonth.month < 10 ? selectedMonth.month.toString().padLeft(2, '0') : selectedMonth.month}")
        //do zmiany
      ],
    );
  }

  hourly() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            _selectDay(context);
          },
          child: Text('Wybierz dzień'),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "godzinowy " + selectedDay.toString(),
            style:
                TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        hourly_chart(
            time:
                "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}"),
      ],
    );
  }

  handleReadOnlyInputClick(context) {
    Container(
        width: MediaQuery.of(context).size.width,
        child: YearPicker(
          selectedDate: DateTime(1997),
          firstDate: DateTime(1995),
          lastDate: DateTime.now(),
          onChanged: (val) {
            print(val);
            Navigator.pop(context);
          },
        ));
  }

  monthly() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            handleReadOnlyInputClick(context);
          },
          child: Text('Wybierz rok'),
        ),
        LineChartWidget()
      ],
    );
  }
}
