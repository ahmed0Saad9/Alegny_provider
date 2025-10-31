import 'package:Alegny_provider/src/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../GeneralWidget/Widgets/DatePickers/date_picker_single.dart';
import '../constants/app_assets.dart';

class DateUtilities {
  DateUtilities._();

  /// ------------------------------ date --------------------------------------
  static String timestampFormatToDate(var timeStamp) {
    DateTime textToDate = DateTime.parse(timeStamp);
    return DateFormat.yMd().add_jm().format(textToDate);
  }

//calc time difference from now
// using it :
// getTimeFromNow(('${posts.dateTime}'))
  static String? getTimeFromNow(String dateTime) {
    String? timeIs;
    Duration difference =
        DateTime.now().toUtc().difference(DateTime.parse(dateTime));

    if (difference.inSeconds < 59) {
      timeIs = 'just_now'.tr;
    } else if (difference.inMinutes < 59) {
      // timeIs = ' ${difference.inMinutes} minutes ago';
      timeIs = "posted_in_number_unit".trParams({
        "time": "${difference.inMinutes}",
        "unit": ("minutes".tr),
      });
    } else if (difference.inHours < 24) {
      timeIs = "posted_in_number_unit".trParams({
        "time": "${difference.inHours}",
        "unit": ("hours".tr),
      });
      // timeIs = ' ${difference.inHours} hours ago';
    } else if (difference.inDays == 7) {
      // timeIs = ' a week ago';
      timeIs = ' a week ago';
    } else if (difference.inDays > 7 && difference.inDays < 14) {
      timeIs = "more_than".tr + "week".tr;
    } else if (difference.inDays == 14) {
      // timeIs = ' 2 weeks ago ';
      timeIs = "two_weeks".tr;
    } else if (difference.inDays > 14 && difference.inDays < 21) {
      timeIs = "more_than".tr + "two_weeks".tr;
      // timeIs = ' more than 2 weeks ';
    } else if (difference.inDays == 21) {
      timeIs = "3${"weeks".tr}";
      // timeIs = ' 3 weeks ago ';
      /// complete
    } else if (difference.inDays > 21 && difference.inDays < 28) {
      timeIs = ' more than 4 weeks ';
    } else if (difference.inDays == 28) {
      timeIs = ' 4 weeks ago ';
    } else if (difference.inDays > 28 && difference.inDays < 31) {
      timeIs = ' a month ago';
    } else if (difference.inDays > 31 && difference.inDays < 60) {
      timeIs = ' more than a month ago';
    } else if (difference.inDays == 60) {
      timeIs = ' 2 months ago';
    } else if (difference.inDays > 60 && difference.inDays < 90) {
      timeIs = ' more than 2 months ago';
    } else if (difference.inDays == 90) {
      timeIs = ' 3 months ago';
    } else if (difference.inDays > 90 && difference.inDays < 120) {
      timeIs = ' more than 3 months ago';
    } else if (difference.inDays == 120) {
      timeIs = ' 4 months ago';
    } else if (difference.inDays > 120 && difference.inDays < 150) {
      timeIs = ' more than 4 months ago';
    } else if (difference.inDays == 150) {
      timeIs = ' 5 months ago';
    } else if (difference.inDays > 150 && difference.inDays < 180) {
      timeIs = ' more than 5 months ago';
    } else if (difference.inDays == 180) {
      timeIs = ' 6 months ago';
    } else if (difference.inDays > 180 && difference.inDays < 210) {
      timeIs = ' more than 6 months ago';
    } else if (difference.inDays == 210) {
      timeIs = ' 7 months ago';
    } else if (difference.inDays > 210 && difference.inDays < 240) {
      timeIs = ' more than 7 months ago';
    } else if (difference.inDays == 240) {
      timeIs = ' 8 months ago';
    } else if (difference.inDays > 240 && difference.inDays < 270) {
      timeIs = ' more than 8 months ago';
    } else if (difference.inDays == 270) {
      timeIs = ' 9 months ago';
    } else if (difference.inDays > 270 && difference.inDays < 300) {
      timeIs = ' more than 9 months ago';
    } else if (difference.inDays == 300) {
      timeIs = ' 10 months ago';
    } else if (difference.inDays > 300 && difference.inDays < 330) {
      timeIs = ' more than 10 months ago';
    } else if (difference.inDays == 330) {
      timeIs = ' 11 months ago';
    } else if (difference.inDays > 330 && difference.inDays < 365) {
      timeIs = ' more than 11 months ago';
    } else if (difference.inDays == 365) {
      timeIs = ' 1 year ago';
    } else {
      timeIs = 'posted in ${(difference.inDays).round()} days ';
    }

    return timeIs;
  }

// something like 2013-04-20
  static String convertDateToYMD(DateTime? date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date!);
    return formatted;
  }

  // something like 30 Mar 2022
  static String convertDateToDDLLL(DateTime date) {
    final String lang = sl<GetStorage>().read('X-Language');
    // final DateFormat formatter = DateFormat('dd LLL yyyy','ar');
    // final String formatted = formatter.format(date);

    var arabicFormat = DateFormat.yMMMMd(lang);
    String formatted = arabicFormat.format(date);

    // printDM(formatted);
    return formatted;
  }

  static String convertTimeToAmPm(String time) {
    // time must be in format like "14:15:00"
    final format = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));
    printDM(format);
    return format;
  }

  static String convertDateToTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  static String convertDateToTime24(DateTime date) {
    final String lang = sl<GetStorage>().read('X-Language');

    return DateFormat('Hm', lang).format(date);
  }

  static String convertDateToTimeAndAddHours(DateTime date, int hour) {
    DateTime endDate = date.add(Duration(hours: hour));
    return DateFormat('h:mm a').format(endDate);
  }

  static String convertDateToTimeAndAddHours24(DateTime date, int hour) {
    DateTime endDate = date.add(Duration(hours: hour));
    return DateFormat('Hm').format(endDate);
  }

  static String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  static String convertDateStringToYMD(String date) {
    final DateFormat formateAfter = DateFormat('yyyy-MM-dd');
    final DateTime dateTime = DateTime.parse(date);
    final String formatted = formateAfter.format(dateTime);
    return formatted;
  }

  static Future<dynamic> showDateTime({
    DateTime? maxDate,
    DateTime? initDateTime,
    bool enablePastDates = false,
    bool showActionButtons = false,
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
                onSubmit: (v) {
                  Get.back(result: v);
                },
                maxDate: maxDate,
                enablePastDates: enablePastDates,
                showActionButtons: showActionButtons,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static bool checkDateAfterOtherValid(DateTime? fromDate, DateTime? toDate) {
    if (fromDate != null && toDate != null) {
      if (toDate.compareTo(fromDate) >= 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static String substringDateMethod(String title) {
    if (title.length > 10) {
      return title.toString().substring(0, 10);
    } else {
      return "";
    }
  }

  // reformat DateTime like "2022-11-27 / 8:28 AM"
  static String reformatDateTime(String dateTime) {
    if (dateTime != "") {
      return "${DateUtilities.convertDateToYMD(DateTime.parse(dateTime))} / ${DateUtilities.convertDateToTime(DateTime.parse(dateTime))}";
    } else {
      return "No Exist!";
    }
  }

  static String convertDateToMDYHMSA(DateTime date) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm:ss a');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String convertStringDateToYMDAndTime(String date) {
    final DateFormat receivedFormat = DateFormat("yyyy-MM-dd'T'hh:mm:ss");
    final DateFormat neededFormat = DateFormat("yyyy-MM-dd hh:mm a");
    final DateTime dateTime = receivedFormat.parse(date);
    return neededFormat.format(dateTime);
  }

  static String convertStringDateToTime(String date) {
    if (date.isNotEmpty) {
      final DateFormat receivedFormat = DateFormat("yyyy-MM-dd'T'hh:mm:ss");
      final DateFormat neededFormat = DateFormat("hh:mm a");
      final DateTime time = receivedFormat.parse(date);
      return neededFormat.format(time);
    } else {
      return "";
    }
  }
}
