import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_version/mobile/jjin_last_datepicker/jjin.dart';
import 'package:mobile_version/mobile/jjin_last_datepicker/last_real.dart';
import 'package:mobile_version/mobile/styles.dart';

class TestFile extends StatefulWidget {
  const TestFile({Key? key}) : super(key: key);

  @override
  _TestFileState createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {
  String test = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Get.dialog(const CustomDatePickerLast()).then((day) {
                    setState(() {
                      test = day;
                    });
                  });
                },
                child: const Text("Dialog Test Button")),
            Text(test),
          ],
        ),
      ),
    );
  }
}
