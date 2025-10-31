

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


extension ScreenSpaces on num {
  // ignore: non_constant_identifier_names
  SizedBox ESW() {
    return SizedBox(width: w,);
  }
  // ignore: non_constant_identifier_names
  SizedBox ESH() {
    return SizedBox(height: h,);
  }

}



extension NavigatorExtension on void {

  void to(BuildContext context , Widget widget, {dynamic args}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    // Navigator.of(context).pushNamed(routName,arguments:  args,);
  }

  void of(BuildContext context , String routName, {dynamic args}) {
    Navigator.of(context).pushReplacementNamed(routName,arguments:  args);
  }

  void offAll(BuildContext context , String routName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routName,(Route<dynamic> route) => false);
  }

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }


}



