import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_version/mobile/material_datepicker/material_datepicker.dart';

class DatePickerTestFile extends StatefulWidget {
  const DatePickerTestFile({Key? key}) : super(key: key);

  @override
  _DatePickerTestFileState createState() => _DatePickerTestFileState();
}

class _DatePickerTestFileState extends State<DatePickerTestFile> {
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("$date"),
            InkWell(
              child: const Text("CalendarDatePicker"),
              onTap: () {
                Get.dialog(const MaterialDatePicker()).then((value) {
                  setState(() {
                    date = value;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
