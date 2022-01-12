import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/mobile/custom_calendar/test.dart';
import 'package:mobile_version/mobile/styles.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:version/version.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (dateTime != null)
              //   Text(
              //       DateFormat('yyyy-MM-dd HH:mm').format(dateTime!).toString())
              // else
              //   const Text('Not selected!'),
              // TextButton(
              //     onPressed: () {
              //       setState(() {
              //         Get.dialog(CustomCalendar(onSelected: (selectedDay) {
              //           setState(() {
              //             dateTime = selectedDay;
              //           });
              //         }));
              //       });
              //     },
              //     child: const Text("TableCalendar"))
              TextButton(
                  onPressed: () {
                    Get.to(const TextFile2());
                  },
                  child: const Text("TestFile")),
            ],
          ),
        ),
      ),
    );
  }
}
