import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/mobile/jjin_last_datepicker/jjin.dart';
import 'package:mobile_version/mobile/jjin_last_datepicker/last_real.dart';
import 'package:mobile_version/mobile/styles.dart';
import 'package:mobile_version/mobile/syncfusion_datepicker/cool_datepicker.dart';
import 'package:mobile_version/mobile/syncfusion_datepicker/sample.dart';
import 'package:mobile_version/mobile/syncfusion_datepicker/syncfusion_datepicker.dart';
import 'package:mobile_version/mobile/syncfusion_datepicker/syncfusion_datepicker_mobile.dart';

class SyncFusionTestFile extends StatefulWidget {
  const SyncFusionTestFile({Key? key}) : super(key: key);

  @override
  _SyncFusionTestFileState createState() => _SyncFusionTestFileState();
}

class _SyncFusionTestFileState extends State<SyncFusionTestFile> {
  DateTime? selectedDay;
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
                  Get.dialog(const CoolDatePicker()).then((day) {
                    setState(() {
                      test = day;
                      selectedDay = DateFormat('yyyy-MM-dd').parse(test);
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
