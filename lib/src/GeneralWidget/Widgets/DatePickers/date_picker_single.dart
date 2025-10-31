import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:Alegny_provider/src/core/constants/app_strings.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

class DatePickerSingleWidget extends StatelessWidget {
  final dynamic Function(Object?) onSubmit;
  final DateTime? initDateTime;
  final DateTime? maxDate;
  final DateTime minDate = DateTime(2000);
  final bool enablePastDates;
  final bool showActionButtons;

  DatePickerSingleWidget({
    this.maxDate,
    this.enablePastDates = true,
    this.showActionButtons = false,
    required this.onSubmit,
    this.initDateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SfDateRangePicker(
              selectionColor: AppColors.main,
              todayHighlightColor: AppColors.main,
              backgroundColor: Colors.white,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: initDateTime,
              initialDisplayDate: DateTime.now(),
              showNavigationArrow: true,
              enablePastDates: enablePastDates,
              cancelText: 'Cancel'.tr,
              confirmText: 'ok'.tr,
              maxDate: maxDate ?? DateTime(2100),
              minDate: minDate,
              showActionButtons: showActionButtons,
              showTodayButton: true,
              onCancel: () {
                Get.back();
              },
              onSubmit: (val) {
                onSubmit(val);
              },
              onSelectionChanged: _onSelectionChanged,
              headerStyle: const DateRangePickerHeaderStyle(
                backgroundColor: AppColors.main,
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: AppStrings.fontFamily,
                ),
              ),
              selectionTextStyle: const TextStyle(
                fontFamily: AppStrings.fontFamily,
              ),
              monthCellStyle: const DateRangePickerMonthCellStyle(
                textStyle: TextStyle(
                  fontFamily: AppStrings.fontFamily,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      // final DateTime rangeStartDate = args.value.startDate;
      // final DateTime rangeEndDate = args.value.endDate;
      onSubmit(args.value.startDate);
    } else if (args.value is DateTime) {
      // final DateTime selectedDate = args.value;
      onSubmit(args.value);
    } else if (args.value is List) {
      // final List  selectedDates = args.value;
      onSubmit(args.value);
    } else {
      // final List  selectedRanges = args.value;
      onSubmit(args.value);
    }
  }
}

Future<void> showCustomDatePicker({
  final DateTime? maxDate,
  required dynamic Function(Object?) onSubmit,
  final DateTime? initDateTime,
  final bool enablePastDates = true,
  final bool showActionButtons = false,
}) {
  return Get.dialog(
    Material(
      color: Colors.black26,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 150.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: Center(
            child: DatePickerSingleWidget(
              initDateTime: initDateTime,
              enablePastDates: enablePastDates,
              showActionButtons: showActionButtons,
              onSubmit: (v) {
                onSubmit(v);
              },
              maxDate: maxDate,
            ),
          ),
        ),
      ),
    ),
  );
}
