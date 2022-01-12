import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// packages
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// styles
import 'package:mobile_version/mobile/styles.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker(
      {Key? key,
      this.onSelected,
      required this.isCombine,
      required this.firstDay,
      required this.lastDay,
      DateTime? currentDay,
      DateTime? focusedDay,
      List<DateTime>? holidays})
      : currentDay = currentDay ?? DateTime.now(),
        focusedDay = focusedDay ?? DateTime.now(),
        holidays = holidays ?? [DateTime(2022, 1, 1)],
        super(key: key);

  final bool isCombine;
  final Function(DateTime dateTime)? onSelected;
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime currentDay;
  final DateTime focusedDay;
  final List<DateTime> holidays;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController hourTextController = TextEditingController();
  TextEditingController minuteTextController = TextEditingController();

  late DateTime selectedDay = widget.currentDay;
  late DateTime focusedDay = widget.focusedDay;
  late List<DateTime> holidays = widget.holidays;

  DateTime? date;

  Widget inputColon = Text(":", style: TextStyles.smallTitleM);
  Widget inputMessage = Text("24시간 기준",
      style: TextStyles.explainR.copyWith(color: ColorSchemes.red));

  var textDecoration = InputDecoration(
      hintText: "00",
      border: InputBorder.none,
      counterText: "",
      hintStyle: TextStyles.smallTitleM.copyWith(color: ColorSchemes.gray500));

  _buildInputTime(TextEditingController controller, double size) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: size,
        height: size,
        decoration: const BoxDecoration(
            color: ColorSchemes.gray100,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 2,
          controller: controller,
          decoration: textDecoration,
        ));
  }

  _buildDatePicker(double width, double headerMargin) {
    return SizedBox(
        width: width,
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
                  color: ColorSchemes.orangeMain, shape: BoxShape.circle),
              selectedTextStyle:
                  TextStyles.contentM.copyWith(color: ColorSchemes.black1),
              weekendTextStyle:
                  TextStyles.contentM.copyWith(color: ColorSchemes.red),
              todayDecoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle)),
          holidayPredicate: (day) =>
              holidays.any((element) => isSameDay(element, day)),
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          headerStyle: HeaderStyle(
              headerMargin:
                  EdgeInsets.only(left: headerMargin, right: headerMargin),
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) {
                return DateFormat('yyyy년 MM월').format(date).toString();
              }),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle:
                  TextStyles.contentM.copyWith(color: ColorSchemes.black1)),
          calendarBuilders:
              CalendarBuilders(outsideBuilder: (context, day, focusedDay) {
            if (day.weekday == DateTime.sunday) {
              return Center(
                  child: Text(day.day.toString(),
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.red.withOpacity(0.3))));
            }
          }, holidayBuilder: (context, day, focusedDay) {
            return Center(
                child: Text(day.day.toString(),
                    style:
                        TextStyles.contentM.copyWith(color: ColorSchemes.red)));
          }, dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              return Center(
                  child: Text("일",
                      style: TextStyles.contentM
                          .copyWith(color: ColorSchemes.red)));
            }
          }),
          weekendDays: const [7],
        ));
  }

  _buildDatePickerCombine() {
    _buildInputBox() {
      List<Widget> children;

      children = [
        const SizedBox(width: 30),
        _buildInputTime(hourTextController, 48),
        inputColon,
        _buildInputTime(minuteTextController, 48),
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
                          int.parse(hourTextController.text),
                          int.parse(minuteTextController.text)));
                    }
                  });
                  Get.back(result: dateTime);
                },
                child: Text("확인",
                    style: TextStyles.contentM
                        .copyWith(color: ColorSchemes.black1))));
      }

      children = [_buildInputBox(), _buildConfirmButton()];
      return SizedBox(child: Stack(children: children));
    }

    Widget grayLine = Container(
        width: Get.width,
        height: 1,
        color: ColorSchemes.gray300,
        margin: const EdgeInsets.only(left: 41, right: 41));

    var decoration = BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorSchemes.orangeMain, width: 1));

    List<Widget> children;

    children = [
      _buildDatePicker(329, 40),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children))));
  }

  _buildDatePickerStep() {
    final pageController = PageController(initialPage: 0);
    _buildDatePickerBox() {
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

      children = [_buildDatePicker(287, 10), _buildButtonBox()];

      return FittedBox(
          fit: BoxFit.scaleDown,
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              type: MaterialType.card,
              child: SizedBox(
                  width: 323,
                  height: 422,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: children))));
    }

    _buildTimePickerBox() {
      _buildTimePicker() {
        List<Widget> children;

        _buildSubmitDatePicker() {
          List<Widget> children;

          Widget date = Text(
              "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
              style: TextStyles.contentB);

          children = [date, inputMessage];
          return Column(children: children);
        }

        _buildInputTimeBody() {
          List<Widget> children;

          _buildInputTimePicker(TextEditingController controller, double size) {
            List<Widget> children;

            Widget timePickerIconUp = IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.arrow_up_s_line,
                    color: ColorSchemes.gray500));
            Widget timePickerIconDown = IconButton(
                onPressed: () {},
                icon: const Icon(FlutterRemix.arrow_down_s_line,
                    color: ColorSchemes.gray500));

            children = [
              timePickerIconUp,
              _buildInputTime(controller, size),
              timePickerIconDown
            ];
            return Column(children: children);
          }

          children = [
            const SizedBox(width: 15),
            _buildSubmitDatePicker(),
            const SizedBox(width: 10),
            _buildInputTimePicker(hourTextController, 82),
            inputColon,
            _buildInputTimePicker(minuteTextController, 82),
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
              child: Row(children: [
                const Icon(FlutterRemix.refresh_line,
                    size: 11, color: ColorSchemes.red),
                const SizedBox(width: 5),
                Text("날짜 재선택",
                    style:
                        TextStyles.contentM.copyWith(color: ColorSchemes.red))
              ]));

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
                  width: 323, height: 260, child: _buildTimePicker())));
    }

    return PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: false,
        children: [_buildDatePickerBox(), _buildTimePickerBox()]);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCombine) {
      return _buildDatePickerCombine();
    }
    return _buildDatePickerStep();
  }
}
