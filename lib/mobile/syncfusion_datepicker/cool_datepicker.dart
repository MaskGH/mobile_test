import 'package:flutter/material.dart';
import 'package:mobile_version/mobile/styles.dart';
import 'package:cool_datepicker/cool_datepicker.dart';

class CoolDatePicker extends StatefulWidget {
  const CoolDatePicker({Key? key}) : super(key: key);

  @override
  _CoolDatePickerState createState() => _CoolDatePickerState();
}

class _CoolDatePickerState extends State<CoolDatePicker> {
  @override
  Widget build(BuildContext context) {
    _buildBody() {
      List<Widget> children;

      _buildCalendar() {
        return CoolDatepicker(
          headerColor: ColorSchemes.white,
          selectedCircleColor: ColorSchemes.orangeMain,
          onSelected: () {},
          calendarSize: 400,
          minYear: 2000,
          maxYear: 2100,
          format: 'yyyy년 mm월 dd일',
          arrowIconAreaColor: ColorSchemes.black1,
          weekLabelList: const ['일', '월', '화', '수', '목', '금', '토'],
          disabledList: [DateTime(2021, 12, 25)],
        );
      }

      children = [_buildCalendar()];
      return Column(children: children);
    }

    return CustomDialog(
      width: 380,
      height: 420,
      enableCancel: false,
      enableConfirm: false,
      enableExitLeft: false,
      enableExitRight: false,
      child: _buildBody(),
    );
  }
}
