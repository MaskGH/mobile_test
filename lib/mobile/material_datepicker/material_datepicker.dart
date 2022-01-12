import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialDatePicker extends StatefulWidget {
  const MaterialDatePicker({Key? key}) : super(key: key);

  @override
  _MaterialDatePickerState createState() => _MaterialDatePickerState();
}

class _MaterialDatePickerState extends State<MaterialDatePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              }),
          TextButton(
              onPressed: () {
                Get.back(result: selectedDate);
              },
              child: const Text("확인")),
        ],
      ),
    );
  }
}
