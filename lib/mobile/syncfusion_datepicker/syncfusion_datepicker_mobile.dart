import 'package:flutter/material.dart';

// packages
import 'package:flutter/scheduler.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// styles
import 'package:mobile_version/mobile/styles.dart';

class SyncFusionDatePickerMobile extends StatefulWidget {
  const SyncFusionDatePickerMobile({Key? key}) : super(key: key);

  @override
  _SyncFusionDatePickerMobileState createState() =>
      _SyncFusionDatePickerMobileState();
}

class _SyncFusionDatePickerMobileState
    extends State<SyncFusionDatePickerMobile> {
  String selectedDate =
      DateFormat('yyyy-mm-dd').format(DateTime.now()).toString();
  String? selectedDayTime;
  String? headerString;

  DateTime? selectedBlackDate;

  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  final DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(args.value).toString();
        selectedBlackDate;
      });
    });
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime startDate = args.visibleDateRange.startDate!;
    final DateTime endDate = args.visibleDateRange.endDate!;
    final int count = endDate.difference(startDate).inDays;

    headerString = DateFormat('yyyy년 MM월')
        .format(startDate.add(Duration(days: (count * 0.25).toInt())))
        .toString();
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

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

  buildDatePickerMobile() {
    List<Widget> children;
    buildDatePickerHeader() {
      List<Widget> children;

      Widget headerYearLabel =
          Text("$headerString", style: TextStyles.smallTitleM);

      IconButton prevIconButton = IconButton(
          onPressed: () {
            setState(() {
              dateRangePickerController.backward!();
            });
          },
          icon: const Icon(FlutterRemix.arrow_left_s_line, size: 16));
      IconButton nextIconButton = IconButton(
          onPressed: () {
            setState(() {
              dateRangePickerController.forward!();
            });
          },
          icon: const Icon(FlutterRemix.arrow_right_s_line, size: 16));
      children = [prevIconButton, headerYearLabel, nextIconButton];
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
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
      return SfDateRangePicker(
        onViewChanged: viewChanged,
        onSelectionChanged: selectionChanged,
        controller: dateRangePickerController,
        initialDisplayDate: DateTime.now(),
        maxDate: DateTime(2030),
        minDate: DateTime(2000),
        headerHeight: 0,
        selectionRadius: 20,
        selectionColor: ColorSchemes.orangeMain,
        todayHighlightColor: ColorSchemes.gray300,
        selectionTextStyle:
            TextStyles.contentM.copyWith(color: ColorSchemes.black1),
        monthCellStyle: DateRangePickerMonthCellStyle(
            leadingDatesTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.gray300),
            trailingDatesTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.gray300),
            blackoutDateTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.red),
            weekendTextStyle:
                TextStyles.contentM.copyWith(color: ColorSchemes.red)),
        monthViewSettings: DateRangePickerMonthViewSettings(
          blackoutDates: [
            DateTime(2021, 12, 25),
            DateTime(2022, 01, 01),
          ],
          showTrailingAndLeadingDates: false,
          viewHeaderHeight: 0,
          weekendDays: const [7],
          weekNumberStyle:
              DateRangePickerWeekNumberStyle(textStyle: TextStyles.contentM),
        ),
      );
    }

    buildTimeBody() {
      List<Widget> children;

      buildTimeLabelInputTime() {
        List<Widget> children;

        buildDateText() {
          List<Widget> children;

          Widget dateText = Text(selectedDate, style: TextStyles.contentB);
          Widget infoText = Text("24시간 기준", style: TextStyles.contentR);

          children = [dateText, infoText];
          return Column(children: children);
        }

        buildInputTime(TextEditingController controller) {
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

          buildIconButton(Function()? onPressed, Icon icon) {
            return IconButton(onPressed: onPressed, icon: icon);
          }

          children = [
            buildIconButton(
                () {},
                const Icon(FlutterRemix.arrow_up_s_line,
                    color: ColorSchemes.gray500)),
            buildDatePickerBottomInputTime(controller),
            buildIconButton(
                () {},
                const Icon(FlutterRemix.arrow_down_s_line,
                    color: ColorSchemes.gray500))
          ];
          return Column(
              mainAxisAlignment: MainAxisAlignment.center, children: children);
        }

        children = [
          buildDateText(),
          buildInputTime(hourController),
          buildInputTime(minuteController),
        ];
        return Row(
            mainAxisAlignment: MainAxisAlignment.center, children: children);
      }

      buildBottomResetConfirm() {
        List<Widget> children;

        Widget resetButton = InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(FlutterRemix.refresh_line,
                  color: ColorSchemes.red, size: 12),
              Text("날짜 재선택",
                  style: TextStyles.contentM.copyWith(color: ColorSchemes.red))
            ],
          ),
        );

        Widget confirmText = InkWell(
            onTap: () {
              setState(() {
                String inputTimeHour = hourController.text;
                String inputTimeMinute = minuteController.text;
                selectedDayTime =
                    "$selectedDate $inputTimeHour:$inputTimeMinute";
                print(selectedDayTime);
              });
              Get.back(result: selectedDayTime);
            },
            child: Text("확인",
                style:
                    TextStyles.contentM.copyWith(color: ColorSchemes.black1)));

        children = [resetButton, confirmText];
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: children);
      }

      children = [buildTimeLabelInputTime(), buildBottomResetConfirm()];
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: children);
    }

    buildDatePickerConfirm() {
      List<Widget> children;

      buildSubmitButton(String text, Function()? onPressed, bool textColor) {
        return TextButton(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyles.contentM.copyWith(
                    color:
                        textColor ? ColorSchemes.black1 : ColorSchemes.red)));
      }

      buildTimeData() {
        return CustomDialog(
          width: 323,
          height: 260,
          enableCancel: false,
          enableConfirm: false,
          enableExitLeft: false,
          enableExitRight: false,
          child: buildTimeBody(),
        );
      }

      children = [
        buildSubmitButton("취소", () {
          setState(() {
            Get.back();
          });
        }, true),
        const SizedBox(width: 20),
        buildSubmitButton("다음", () {
          Get.dialog(buildTimeData());
        }, false),
        const SizedBox(width: 20),
      ];
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: children);
    }

    children = [
      buildDatePickerHeader(),
      buildDatePickerBodyLabel(),
      buildDatePickerCalendar(),
      buildDatePickerConfirm(),
      const SizedBox(height: 10),
    ];
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, children: children));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      width: 323,
      height: 422,
      enableCancel: false,
      enableConfirm: false,
      enableExitLeft: false,
      enableExitRight: false,
      child: buildDatePickerMobile(),
    );
  }
}
