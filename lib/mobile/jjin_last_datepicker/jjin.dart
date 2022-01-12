import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/mobile/styles.dart';

class CustomDatePickerDialog extends StatefulWidget {
  const CustomDatePickerDialog({Key? key}) : super(key: key);

  @override
  _CustomDatePickerDialogState createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  DateTime currentDate = DateTime.now();
  DateTime currentDate2 = DateTime.now();
  DateTime targetDateTime = DateTime.now();
  String currentMonth = DateFormat.yMd().format(DateTime.now());
  String dateTimeYear = DateFormat.y().format(DateTime.now());
  String dateTimeMonth = DateFormat.M().format(DateTime.now());
  String dateTimeHour = DateFormat.H().format(DateTime.now());
  String dateTimeMinute = DateFormat.M().format(DateTime.now());
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  var decoration = BoxDecoration(
    color: ColorSchemes.white,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    border: Border.all(
      color: ColorSchemes.orangeMain,
    ),
  );

  var line = Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      width: Get.width,
      height: 1,
      color: ColorSchemes.gray300);

  var equal = Text(":", style: TextStyles.smallTitleM);

  var inputMessage = Text("24시간 기준",
      style: TextStyles.explainR.copyWith(color: ColorSchemes.red));

  _buildDatePickerHeader(
      Function()? onPressedPrev, Function()? onPressedNext, Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPressedPrev,
            icon: const Icon(FlutterRemix.arrow_left_s_line, size: 16)),
        child,
        IconButton(
            onPressed: onPressedNext,
            icon: const Icon(FlutterRemix.arrow_right_s_line, size: 16)),
      ],
    );
  }

  _buildDatePickerHeader2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                targetDateTime =
                    DateTime(targetDateTime.year, targetDateTime.month - 1);
                currentMonth = DateFormat.yMd().format(targetDateTime);
              });
            },
            icon: const Icon(FlutterRemix.arrow_left_s_line, size: 16)),
        IconButton(
            onPressed: () {
              setState(() {
                targetDateTime =
                    DateTime(targetDateTime.year, targetDateTime.month + 1);
                currentMonth = DateFormat.yMd().format(targetDateTime);
              });
            },
            icon: const Icon(FlutterRemix.arrow_right_s_line, size: 16)),
      ],
    );
  }

  buildDatePickerBodyLabel() {
    List<Widget> children;

    var sun =
        Text("일", style: TextStyles.contentM.copyWith(color: ColorSchemes.red));
    var mon = Text("월", style: TextStyles.contentM);
    var tues = Text("화", style: TextStyles.contentM);
    var wednes = Text("수", style: TextStyles.contentM);
    var thurs = Text("목", style: TextStyles.contentM);
    var fri = Text("금", style: TextStyles.contentM);
    var satur = Text("토", style: TextStyles.contentM);

    children = [sun, mon, tues, wednes, thurs, fri, satur];
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
  }

  buildDatePickerCalendar(Function(DateTime, List<Event>)? onDayPressed,
      Function(DateTime)? onCalendarChanged) {
    return CalendarCarousel(
      onDayPressed: onDayPressed,
      onCalendarChanged: onCalendarChanged,
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

  buildDatePickerCalendar2() {
    return CalendarCarousel(
      onDayLongPressed: (date) {
        setState(() {
          currentDate2 = date;
          print(currentDate2);
        });
      },
      onCalendarChanged: (date) {
        setState(() {
          targetDateTime = date;
          currentMonth = DateFormat.yMMM().format(targetDateTime);
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
              hintStyle:
                  TextStyles.smallTitleM.copyWith(color: ColorSchemes.gray500)),
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

  buildDatePickerConfirm(Function()? onPressed) {
    return Container(
        alignment: Alignment.topRight,
        child: TextButton(
            onPressed: onPressed,
            child: Text("확인",
                style:
                    TextStyles.contentM.copyWith(color: ColorSchemes.black1))));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      enableCancel: false,
      enableConfirm: true,
      enableExitLeft: false,
      enableExitRight: false,
      decoration: decoration,
      width: 390,
      height: 461,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _buildDatePickerHeader(() {
          //   setState(() {
          //     targetDateTime =
          //         DateTime(targetDateTime.year, targetDateTime.month - 1);
          //     currentMonth = DateFormat.yMd().format(targetDateTime);
          //   });
          // }, () {
          //   setState(() {
          //     targetDateTime =
          //         DateTime(targetDateTime.year, targetDateTime.month + 1);
          //     currentMonth = DateFormat.yMd().format(targetDateTime);
          //   });
          // },
          //     Text("${targetDateTime.year}년 ${targetDateTime.month}월",
          //         style: TextStyles.smallTitleM)),
          _buildDatePickerHeader2(),
          buildDatePickerBodyLabel(),
          buildDatePickerCalendar((date, events) {
            setState(() {
              currentDate2 = date;
              print(currentDate2);
            });
          }, (date) {
            // setState(() {
            //   targetDateTime = date;
            //   currentMonth = DateFormat.yMMM().format(targetDateTime);
            // });
          }),
          line,
          const Spacer(),
          buildDatePickerBottomInput(),
          buildDatePickerConfirm(
              () => Get.back(result: currentDate2.toString()))
        ],
      ),
    );
  }
}



// return AlertDialog(
//       shape: const RoundedRectangleBorder(
//           side: BorderSide(color: ColorSchemes.orangeMain),
//           borderRadius: BorderRadius.all(Radius.circular(10.0))),
//       content: StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             width: 390,
//             height: 461,
//             margin: const EdgeInsets.all(5),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildDatePickerHeader(() {
//                   setState(() {
//                     targetDateTime =
//                         DateTime(targetDateTime.year, targetDateTime.month - 1);
//                     currentMonth = DateFormat.yMd().format(targetDateTime);
//                   });
//                 }, () {
//                   setState(() {
//                     targetDateTime =
//                         DateTime(targetDateTime.year, targetDateTime.month + 1);
//                     currentMonth = DateFormat.yMd().format(targetDateTime);
//                   });
//                 },
//                     Text("${targetDateTime.year}년 ${targetDateTime.month}월",
//                         style: TextStyles.smallTitleM)),
//                 buildDatePickerBodyLabel(),
//                 buildDatePickerCalendar((date, events) {
//                   setState(() {
//                     currentDate2 = date;
//                     print(currentDate2);
//                   });
//                 }, (date) {
//                   // setState(() {
//                   //   targetDateTime = date;
//                   //   currentMonth = DateFormat.yMMM().format(targetDateTime);
//                   // });
//                 }),
//                 line,
//                 const Spacer(),
//                 buildDatePickerBottomInput(),
//                 buildDatePickerConfirm(
//                     () => Get.back(result: currentDate2.toString()))
//               ],
//             ),
//           );
//         },
//       ),
//     )