import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HeaderCustomization extends StatefulWidget {
  @override
  _HeaderCustomizationState createState() => _HeaderCustomizationState();
}

class _HeaderCustomizationState extends State<HeaderCustomization> {
  final DateRangePickerController _controller = DateRangePickerController();
  String headerString = '';
  DateTime? date;
  List<DateTime> blackDates = <DateTime>[];

  // List<DateTime> _blackoutDateCollection = <DateTime>[];
  // late List<DateTime> _activeDates;

  void viewChanged(DateRangePickerViewChangedArgs args) {
    List<DateTime> _blackoutDateCollection = <DateTime>[];
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    _blackoutDateCollection.add(visibleStartDate);
    _blackoutDateCollection.add(visibleStartDate.add(Duration(days: 15)));
    _blackoutDateCollection.add(visibleStartDate.add(Duration(days: 7)));
    _blackoutDateCollection.add(visibleStartDate.add(Duration(days: 3)));
    _blackoutDateCollection.add(visibleStartDate.add(Duration(days: 4)));
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        blackDates = _blackoutDateCollection;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / 9;

    return Scaffold(
        body: Center(
      child: SfDateRangePicker(
        selectionMode: DateRangePickerSelectionMode.single,
        monthViewSettings:
            DateRangePickerMonthViewSettings(blackoutDates: blackDates),
        monthCellStyle: DateRangePickerMonthCellStyle(
          blackoutDateTextStyle: TextStyle(
              color: Colors.red, decoration: TextDecoration.lineThrough),
        ),
        onViewChanged: viewChanged,
      ),
    ));
  }
}
