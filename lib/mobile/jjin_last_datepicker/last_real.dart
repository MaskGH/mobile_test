import 'package:flutter/material.dart';

// packages
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// styles
import 'package:mobile_version/mobile/styles.dart';

class CustomDatePickerLast extends StatefulWidget {
  const CustomDatePickerLast({Key? key}) : super(key: key);

  @override
  _CustomDatePickerLastState createState() => _CustomDatePickerLastState();
}

class _CustomDatePickerLastState extends State<CustomDatePickerLast> {
  DateTime currentDate = DateTime.now();
  DateTime currentDate2 = DateTime.now();
  DateTime targetDateTime = DateTime.now();

  late String selectedDay;
  late String selectedDayTime;

  String currentMonth = DateFormat.yMd().format(DateTime.now());
  String dateTimeYear = DateFormat.y().format(DateTime.now());
  String dateTimeMonth = DateFormat.M().format(DateTime.now());

  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  BoxDecoration decoration = BoxDecoration(
    color: ColorSchemes.white,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    border: Border.all(
      color: ColorSchemes.orangeMain,
    ),
  );

  Widget line = Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      width: Get.width,
      height: 1,
      color: ColorSchemes.gray300);

  Widget equal = Text(":", style: TextStyles.smallTitleM);

  Widget inputMessage = Text("24시간 기준",
      style: TextStyles.explainR.copyWith(color: ColorSchemes.red));

  buildDatePicker() {
    List<Widget> children;
    buildDatePickerHeaderYear() {
      return Text("${targetDateTime.year}년 ${targetDateTime.month}월",
          style: TextStyles.smallTitleM);
    }

    buildDatePickerHeader() {
      List<Widget> children;
      var prevIconButton = IconButton(
          onPressed: () {
            setState(() {
              targetDateTime =
                  DateTime(targetDateTime.year, targetDateTime.month - 1);
              currentMonth = DateFormat.yMd().format(targetDateTime);
            });
          },
          icon: const Icon(FlutterRemix.arrow_left_s_line, size: 16));
      var nextIconButton = IconButton(
          onPressed: () {
            setState(() {
              targetDateTime =
                  DateTime(targetDateTime.year, targetDateTime.month + 1);
              currentMonth = DateFormat.yMd().format(targetDateTime);
            });
          },
          icon: const Icon(FlutterRemix.arrow_right_s_line, size: 16));
      children = [prevIconButton, buildDatePickerHeaderYear(), nextIconButton];
      return Row(
          mainAxisAlignment: MainAxisAlignment.center, children: children);
    }

    buildDatePickerBodyLabel() {
      List<Widget> children;

      Widget sun = Text("일",
          style: TextStyles.contentM.copyWith(color: ColorSchemes.red));
      Widget mon = Text("월", style: TextStyles.contentM);
      Widget tues = Text("화", style: TextStyles.contentM);
      Widget wednes = Text("수", style: TextStyles.contentM);
      Widget thurs = Text("목", style: TextStyles.contentM);
      Widget fri = Text("금", style: TextStyles.contentM);
      Widget satur = Text("토", style: TextStyles.contentM);

      children = [sun, mon, tues, wednes, thurs, fri, satur];
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
    }

    buildDatePickerCalendar() {
      return CalendarCarousel(
        onDayPressed: (date, events) {
          setState(() {
            currentDate2 = date;
            selectedDay = DateFormat('yyyy-MM-dd').format(currentDate2);
          });
        },
        pageScrollPhysics: const NeverScrollableScrollPhysics(),
        todayBorderColor: ColorSchemes.gray300,
        daysHaveCircularBorder: true,
        showOnlyCurrentMonthDate: false,
        selectedDateTime: currentDate2,
        targetDateTime: targetDateTime,
        todayButtonColor: ColorSchemes.gray300,
        minSelectedDate: DateTime(2000),
        maxSelectedDate: DateTime(2030),
        selectedDayButtonColor: ColorSchemes.orangeMain,
        selectedDayBorderColor: ColorSchemes.orangeMain,
        selectedDayTextStyle:
            TextStyles.contentM.copyWith(color: ColorSchemes.black1),
        weekendTextStyle: TextStyles.contentM.copyWith(color: ColorSchemes.red),
        nextDaysTextStyle:
            TextStyles.contentM.copyWith(color: ColorSchemes.gray300),
        prevDaysTextStyle:
            TextStyles.contentM.copyWith(color: ColorSchemes.gray300),
        weekdayTextStyle: TextStyles.explainM,
        weekDayFormat: WeekdayFormat.short,
        firstDayOfWeek: 0,
        showHeader: false,
        weekFormat: false,
        staticSixWeekFormat: true,
        height: 299,
        showWeekDays: false,
      );
    }

    buildDatePickerBottomInput() {
      List<Widget> children;
      buildDatePickerBottomInputTime(TextEditingController controller) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
              color: ColorSchemes.gray100,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextFormField(
            textAlign: TextAlign.center,
            maxLength: 2,
            controller: controller,
            decoration: InputDecoration(
                hintText: "00",
                border: InputBorder.none,
                counterText: "",
                hintStyle: TextStyles.smallTitleM
                    .copyWith(color: ColorSchemes.gray500)),
          ),
        );
      }

      children = [
        buildDatePickerBottomInputTime(hourController),
        equal,
        buildDatePickerBottomInputTime(minuteController),
        inputMessage
      ];
      return Row(children: children);
    }

    buildDatePickerBottomStack() {
      List<Widget> children;
      buildDatePickerConfirm() {
        return Positioned(
          right: 10,
          bottom: -5,
          child: TextButton(
              onPressed: () {
                setState(() {
                  String inputTimeHour = hourController.text;
                  String inputTimeMinute = minuteController.text;
                  selectedDayTime =
                      "$selectedDay $inputTimeHour:$inputTimeMinute";
                });
                Get.back(result: selectedDayTime);
              },
              child: Text("확인",
                  style: TextStyles.contentM
                      .copyWith(color: ColorSchemes.black1))),
        );
      }

      children = [buildDatePickerBottomInput(), buildDatePickerConfirm()];
      return Stack(children: children);
    }

    children = [
      buildDatePickerHeader(),
      const SizedBox(height: 5),
      buildDatePickerBodyLabel(),
      buildDatePickerCalendar(),
      line,
      const SizedBox(height: 5),
      buildDatePickerBottomStack()
    ];
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        width: 390,
        height: 461,
        enableCancel: false,
        enableExitLeft: false,
        enableExitRight: false,
        enableConfirm: false,
        decoration: decoration,
        child: buildDatePicker());
  }
}
