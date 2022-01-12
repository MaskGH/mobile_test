import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';

// packages
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// styles
import 'package:mobile_version/mobile/styles.dart';

class CustomDatePickerMobile extends StatefulWidget {
  CustomDatePickerMobile(
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
  _CustomDatePickerMobileState createState() => _CustomDatePickerMobileState();
}

class _CustomDatePickerMobileState extends State<CustomDatePickerMobile> {
  final hourTextController = TextEditingController();
  final minuteTextController = TextEditingController();
  final pageController = PageController(initialPage: 0);

  late DateTime selectedDay = widget.currentDay;
  late DateTime focusedDay = widget.focusedDay;
  late List<DateTime> holidays = widget.holidays;

  _buildDatePickerStep() {
    _buildDatePickerBox() {
      _buildDatePicker() {
        return SizedBox(
          width: 287,
          child: TableCalendar(
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
              headerMargin: const EdgeInsets.only(left: 30, right: 30),
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
                        style: TextStyles.contentM.copyWith(
                            color: ColorSchemes.red.withOpacity(0.3))),
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

      _buildButtonBox() {
        List<Widget> children;

        Widget cancelButton = TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("취소",
                style:
                    TextStyles.contentM.copyWith(color: ColorSchemes.black1)));

        Widget confirmButton = TextButton(
            onPressed: () {
              setState(() {
                if (widget.onSelected != null) {
                  widget.onSelected!(DateTime(
                      selectedDay.year, selectedDay.month, selectedDay.day));
                }
                pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn);
              });
            },
            child: Text("다음",
                style: TextStyles.contentM.copyWith(color: ColorSchemes.red)));

        children = [cancelButton, confirmButton];
        return Row(
            mainAxisAlignment: MainAxisAlignment.end, children: children);
      }

      List<Widget> children;

      children = [
        _buildDatePicker(),
        _buildButtonBox(),
      ];

      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          type: MaterialType.card,
          child: SizedBox(
            width: 323,
            height: 422,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start, children: children),
          ),
        ),
      );
    }

    _buildTimePickerBox() {
      _buildTimePicker() {
        List<Widget> children;

        _buildSubmitDatePicker() {
          List<Widget> children;

          Widget date = Text(
              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
              style: TextStyles.contentB);
          Widget inputInfo = Text(
            "24시간 기준",
            style: TextStyles.contentR,
          );

          children = [date, inputInfo];
          return Column(children: children);
        }

        _buildInputTimeBody() {
          List<Widget> children;

          Widget inputColon = Text(":", style: TextStyles.smallTitleM);

          _buildInputTimePicker(TextEditingController controller) {
            List<Widget> children;

            Widget timePickerIconUp = IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.arrow_up_s_line,
                    color: ColorSchemes.gray500));
            Widget timePickerIconDown = IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.arrow_down_s_line,
                    color: ColorSchemes.gray500));

            Widget inputTime = Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                  color: ColorSchemes.gray100,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 2,
                controller: controller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    hintText: "00",
                    border: InputBorder.none,
                    counterText: "",
                    hintStyle: TextStyles.smallTitleM
                        .copyWith(color: ColorSchemes.gray500)),
              ),
            );

            children = [timePickerIconUp, inputTime, timePickerIconDown];
            return Column(children: children);
          }

          children = [
            const SizedBox(width: 15),
            _buildSubmitDatePicker(),
            const SizedBox(width: 10),
            _buildInputTimePicker(hourTextController),
            inputColon,
            _buildInputTimePicker(minuteTextController)
          ];
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children);
        }

        _buildInputSubmit() {
          List<Widget> children;
          DateTime? dateTime;

          Widget refreshDateButton = TextButton(
              onPressed: () {
                setState(() {
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn);
                });
              },
              child: Row(
                children: [
                  const Icon(
                    FlutterRemix.refresh_line,
                    size: 11,
                    color: ColorSchemes.red,
                  ),
                  const SizedBox(width: 5),
                  Text("날짜 재선택",
                      style:
                          TextStyles.contentM.copyWith(color: ColorSchemes.red))
                ],
              ));

          Widget submitTextButton = TextButton(
              onPressed: () {
                setState(() {
                  if (widget.onSelected != null) {
                    widget.onSelected!(DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                        int.parse(hourTextController.text),
                        int.parse(minuteTextController.text)));
                  }
                });
                Get.back(result: dateTime);
              },
              child: Text("확인",
                  style: TextStyles.contentM
                      .copyWith(color: ColorSchemes.black1)));

          children = [
            const SizedBox(width: 15),
            refreshDateButton,
            const Spacer(),
            submitTextButton,
            const SizedBox(width: 15)
          ];
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children);
        }

        children = [
          const SizedBox(height: 10),
          _buildInputTimeBody(),
          const SizedBox(height: 10),
          _buildInputSubmit(),
          const SizedBox(height: 10)
        ];
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children);
      }

      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          type: MaterialType.card,
          child: SizedBox(
            width: 323,
            height: 260,
            child: _buildTimePicker(),
          ),
        ),
      );
    }

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: false,
      children: [_buildDatePickerBox(), _buildTimePickerBox()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDatePickerStep();
  }
}
