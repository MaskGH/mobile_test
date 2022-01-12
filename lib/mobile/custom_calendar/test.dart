import 'package:flutter/material.dart';

// packages
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/mobile/custom_calendar/datepicker.dart';

class TextFile2 extends StatefulWidget {
  const TextFile2({Key? key}) : super(key: key);

  @override
  _TextFile2State createState() => _TextFile2State();
}

class _TextFile2State extends State<TextFile2> {
  DateTime? pickerDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$pickerDay"),
            TextButton(
                onPressed: () {
                  setState(() {
                    Get.dialog(CustomDatePicker(
                      isCombine: true,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2050),
                      holidays: [DateTime(2022, 1, 1)],
                      onSelected: (dateTime) {
                        setState(() {
                          pickerDay = dateTime;
                        });
                      },
                    ));
                  });
                },
                child: const Text("DatePickerMobile")),
          ],
        ),
      ),
    );
  }
}
