import 'package:flutter/material.dart';
import 'package:telicznik/Meters/MeterManager.dart';
import 'package:telicznik/charts/chart_template.dart';
import 'package:telicznik/charts/charts_data.dart';
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
      if (picked != null) selectedMonth = picked;
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
      if (picked != null) selectedDay = picked;
      print(
          "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}");
    });
  }

  _selectYear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wybierz rok"),
          content: Container(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate:
                  DateTime.parse(MeterManager.getCurrentMeter().DateFrom),
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
            ),
          ),
        );
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
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: const Color.fromARGB(255, 236, 0, 217).withOpacity(.16),
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
                child: const Text('Godzinny'),
              ),
              const SizedBox(width: 10),
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
                child: const Text('Dzienny'),
              ),
              const SizedBox(width: 10),
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
                child: const Text('Miesięczny'),
              ),
              const SizedBox(width: 10),
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
                child: const Text('Zakres'),
              )
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [const SizedBox(height: 40), buttons, GetChart()],
      ),
      drawer: PublicDrawer(),
      appBar: const PublicAppBar(),
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
          child: const Text('Wybierz miesiąc'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "dzienny $selectedMonth",
            style: const TextStyle(
                fontSize: 16.0, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        chart_template(
            time:
                "${selectedMonth.year}-${selectedMonth.month < 10 ? selectedMonth.month.toString().padLeft(2, '0') : selectedMonth.month}",
            datausage: createDailyUsage(
                "${selectedMonth.year}-${selectedMonth.month < 10 ? selectedMonth.month.toString().padLeft(2, '0') : selectedMonth.month}"),
            datageneration: createDailyGeneration(
                "${selectedMonth.year}-${selectedMonth.month < 10 ? selectedMonth.month.toString().padLeft(2, '0') : selectedMonth.month}"))
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
          child: const Text('Wybierz dzień'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "godzinowy $selectedDay",
            style: const TextStyle(
                fontSize: 16.0, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        chart_template(
            time:
                "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}",
            datausage: createHourlyUsage(
                "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}"),
            datageneration: createHourlyGeneration(
                "${selectedDay.year}-${selectedDay.month < 10 ? selectedDay.month.toString().padLeft(2, '0') : selectedDay.month}-${selectedDay.day < 10 ? selectedDay.day.toString().padLeft(2, '0') : selectedDay.day}")),
      ],
    );
  }

  monthly() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            _selectYear(context);
          },
          child: const Text('Wybierz rok'),
        ),
        chart_template(
            time: "",
            datausage: createMonthlyUsage(),
            datageneration: createMonthlyGeneration())
      ],
    );
  }
}
