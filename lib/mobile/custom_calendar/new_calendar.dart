import 'package:flutter/material.dart';

// packages
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// styles
import 'package:mobile_version/mobile/styles.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker(
      {Key? key,
      this.onSelected,
      required this.firstDay,
      required this.lastDay,
      DateTime? currentDay,
      DateTime? focusedDay,
      List<DateTime>? holidays})
      : currentDay = currentDay ?? DateTime.now(),
        focusedDay = focusedDay ?? DateTime.now(),
        holidays = holidays ?? [DateTime(2022, 1, 1)],
        super(key: key);

  final Function(DateTime dateTime)? onSelected;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime currentDay;
  final DateTime focusedDay;
  final List<DateTime> holidays;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDay = widget.currentDay;
  late DateTime focusedDay = widget.focusedDay;

  late List<DateTime> holidays = widget.holidays;

  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  _buildDatePickerCombine() {
    _buildDatePicker() {
      return SizedBox(
        width: 329,
        child: TableCalendar(
          currentDay: widget.currentDay,
          focusedDay: focusedDay,
          firstDay: widget.firstDay,
          lastDay: widget.lastDay,
          locale: 'ko_KR',
          sixWeekMonthsEnforced: true,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: ColorSchemes.orangeMain,
              shape: BoxShape.circle,
            ),
            selectedTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.black1),
            weekendTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.red),
            todayDecoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          holidayPredicate: (day) =>
              holidays.any((element) => isSameDay(element, day)),
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          headerStyle: HeaderStyle(
            headerMargin: const EdgeInsets.only(left: 40, right: 40),
            formatButtonVisible: false,
            titleCentered: true,
            titleTextFormatter: (date, locale) {
              return DateFormat('yyyy년 MM월').format(date).toString();
            },
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.black1),
          ),
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              if (day.weekday == DateTime.sunday) {
                return Center(
                  child: Text(day.day.toString(),
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.red.withOpacity(0.3))),
                );
              }
            },
            holidayBuilder: (context, day, focusedDay) {
              return Center(
                  child: Text(day.day.toString(),
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.red)));
            },
            dowBuilder: (context, day) {
              if (day.weekday == DateTime.sunday) {
                return Center(
                  child: Text("일",
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.red)),
                );
              }
            },
          ),
          weekendDays: const [7],
        ),
      );
    }

    _buildInputBox() {
      List<Widget> children;

      Widget inputColon = Text(":", style: TextStyles.smallTitleM);
      Widget inputMessage = Text("24시간 기준",
          style: TextStyles.explainR.copyWith(color: ColorSchemes.red));

      _buildInputTime(TextEditingController controller) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
              color: ColorSchemes.gray100,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextFormField(
            keyboardType: TextInputType.number,
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
        const SizedBox(width: 30),
        _buildInputTime(hourController),
        inputColon,
        _buildInputTime(minuteController),
        inputMessage
      ];
      return Row(children: children);
    }

    _buildInputTimeConfirm() {
      List<Widget> children;

      _buildConfirmButton() {
        DateTime? dateTime;

        return Positioned(
          right: 10,
          bottom: -5,
          child: TextButton(
              onPressed: () {
                setState(() {
                  if (widget.onSelected != null) {
                    widget.onSelected!(DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                        int.parse(hourController.text),
                        int.parse(minuteController.text)));
                  }
                });
                Get.back(result: dateTime);
              },
              child: Text("확인",
                  style: TextStyles.contentM
                      .copyWith(color: ColorSchemes.black1))),
        );
      }

      children = [_buildInputBox(), _buildConfirmButton()];
      return SizedBox(child: Stack(children: children));
    }

    Widget grayLine = Container(
      width: Get.width,
      height: 1,
      color: ColorSchemes.gray300,
      margin: const EdgeInsets.only(left: 41, right: 41),
    );

    var decoration = BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorSchemes.orangeMain, width: 1));

    List<Widget> children;

    children = [
      _buildDatePicker(),
      grayLine,
      const SizedBox(height: 5),
      _buildInputTimeConfirm()
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        type: MaterialType.card,
        child: Container(
          width: 390,
          height: 461,
          decoration: decoration,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start, children: children),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePickerCombine();
  }
}
