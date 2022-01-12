import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../styles.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({Key? key}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime currentDate2 = DateTime.now();
    DateTime targetDateTime = DateTime.now();
    String currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
    String dateTimeYear = DateFormat.y().format(DateTime.now());
    String dateTimeMonth = DateFormat.M().format(DateTime.now());
    String dateTimeHour = DateFormat.H().format(DateTime.now());
    String dateTimeMinute = DateFormat.M().format(DateTime.now());
    TextEditingController hourController = TextEditingController();
    TextEditingController minuteController = TextEditingController();

    buildCalendarBottom() {
      List<Widget> children;

      buildCalendarBottomTimer(String time, TextEditingController controller) {
        return Container(
          alignment: Alignment.center,
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

      var equal = Text(":", style: TextStyles.smallTitleM);

      var timeMessage = Text("24시간 기준",
          style: TextStyles.explainR.copyWith(color: ColorSchemes.red));

      children = [
        const SizedBox(width: 40),
        buildCalendarBottomTimer(dateTimeHour, hourController),
        const SizedBox(width: 10),
        equal,
        const SizedBox(width: 10),
        buildCalendarBottomTimer(dateTimeMinute, minuteController),
        const SizedBox(width: 10),
        timeMessage,
        const Spacer(),
      ];
      return Row(children: children);
    }

    var enterButton = Container(
        alignment: Alignment.bottomRight,
        child: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("확인",
                style:
                    TextStyles.contentM.copyWith(color: ColorSchemes.black1))));

    buildCalendarBottomStack() {
      List<Widget> children;
      children = [
        buildCalendarBottom(),
        enterButton,
      ];
      return Stack(
        children: children,
      );
    }

    var confirmButton = Container(
      padding: const EdgeInsets.only(right: 30, bottom: 10),
      width: 390,
      child: Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("확인",
                  style: TextStyles.contentM
                      .copyWith(color: ColorSchemes.black1)))),
    );

    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: 390,
              height: 461,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: ColorSchemes.orangeMain,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              targetDateTime = DateTime(targetDateTime.year,
                                  targetDateTime.month - 1);
                              currentMonth =
                                  DateFormat.yMMM().format(targetDateTime);
                            });
                          },
                          icon: const Icon(FlutterRemix.arrow_left_s_line,
                              size: 16)),
                      Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: Text(
                              "${targetDateTime.year}년 ${targetDateTime.month}월",
                              style: TextStyles.smallTitleM)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              targetDateTime = DateTime(targetDateTime.year,
                                  targetDateTime.month + 1);
                              currentMonth =
                                  DateFormat.yMMM().format(targetDateTime);
                            });
                          },
                          icon: const Icon(FlutterRemix.arrow_right_s_line,
                              size: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 329,
                    child: Column(
                      children: [
                        buildCalendarBodyLabel(),
                        CalendarCarousel(
                          onDayPressed: (DateTime date, List<Event> events) {
                            setState(() {
                              currentDate2 = date;
                              print(currentDate);
                            });
                          },
                          onCalendarChanged: (DateTime date) {
                            setState(() {
                              targetDateTime = date;
                              currentMonth =
                                  DateFormat.yMMM().format(targetDateTime);
                            });
                          },
                          pageScrollPhysics:
                              const NeverScrollableScrollPhysics(),
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
                          selectedDayTextStyle: TextStyles.contentM
                              .copyWith(color: ColorSchemes.black1),
                          weekendTextStyle: TextStyles.contentM
                              .copyWith(color: ColorSchemes.red),
                          nextDaysTextStyle: TextStyles.contentM
                              .copyWith(color: ColorSchemes.gray300),
                          prevDaysTextStyle: TextStyles.contentM
                              .copyWith(color: ColorSchemes.gray300),
                          weekdayTextStyle: TextStyles.explainM,
                          weekDayFormat: WeekdayFormat.short,
                          firstDayOfWeek: 0,
                          showHeader: false,
                          weekFormat: false,
                          staticSixWeekFormat: true,
                          height: 290,
                          showWeekDays: false,
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Container(
                      margin: const EdgeInsets.only(left: 45, right: 45),
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: ColorSchemes.gray300),
                  const Spacer(),
                  buildCalendarBottom(),
                  const Spacer(),
                ],
              ),
            );
          },
        ));
  }

  buildCalendarBodyLabel() {
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
}
