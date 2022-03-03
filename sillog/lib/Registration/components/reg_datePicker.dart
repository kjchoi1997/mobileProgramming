import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late final sillogController;
  late final PickerDateRange? _initialSelectedRange;

  @override
  initState() {
    super.initState();
    sillogController = Get.find<SillogController>();
    if (sillogController.dateList.length == 1)
      _initialSelectedRange =
          PickerDateRange(DateTime.parse(sillogController.dateList[0]), null);
    else if (sillogController.dateList.length == 2)
      _initialSelectedRange = PickerDateRange(
          DateTime.parse(sillogController.dateList[0]),
          DateTime.parse(sillogController.dateList[1]));
    else {
      _initialSelectedRange = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 330,
        width: 0.9.sw,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  blurRadius: 10.0,
                  spreadRadius: 3.0)
            ]),
        child: SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            headerHeight: 50.h,
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            initialSelectedRange: _initialSelectedRange,
            selectionTextStyle: const TextStyle(color: Colors.white),
            selectionColor: Color(0xFFE5EAEF),
            startRangeSelectionColor: Color(0xFF163C6B),
            endRangeSelectionColor: Color(0xFF163C6B),
            rangeSelectionColor: Color(0xFFE5EAEF),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              todayTextStyle: TextStyle(color: Color(0xFF163C6B)),
              todayCellDecoration: BoxDecoration(
                // color: Color(0xFFE5EAEF),
                border: Border.all(color: const Color(0xFF163C6B), width: 1),
                shape: BoxShape.circle,
              ),
            ),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value.startDate != null) {
                sillogController.dateList = [
                  DateFormat('yyyy-MM-dd', 'en').format(args.value.startDate),
                ];
                if (args.value.endDate != null) {
                  if (args.value.startDate == args.value.endDate) {
                    sillogController.dateList = [
                      DateFormat('yyyy-MM-dd', 'en')
                          .format(args.value.startDate),
                    ];
                  } else {
                    sillogController.dateList = [
                      DateFormat('yyyy-MM-dd', 'en')
                          .format(args.value.startDate),
                      DateFormat('yyyy-MM-dd', 'en').format(args.value.endDate),
                    ];
                  }
                }
              }
            }));
  }
}
