import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPadding {
  static EdgeInsetsGeometry paddingScreenSH16 =
      EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsetsGeometry paddingScreenSV16 =
      EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsetsGeometry paddingScreenSH8 =
      EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsetsGeometry paddingScreenSH8SV8 =
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h);
  static EdgeInsetsGeometry paddingScreenSH16SV8 =
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
  static EdgeInsetsGeometry paddingScreenSH16SV16 =
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);
  static EdgeInsetsGeometry paddingScreenSH36 =
      EdgeInsets.symmetric(horizontal: 36.w);
  static EdgeInsetsGeometry paddingScreenSH22 =
      EdgeInsets.symmetric(horizontal: 22.w);
  static EdgeInsetsGeometry paddingScreenSH22SV22 =
      EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h);
  static EdgeInsetsGeometry paddingButtonBottomSH70 =
      EdgeInsets.only(bottom: 70.h);
  static EdgeInsetsGeometry paddingAppBarAll =
      const EdgeInsets.fromLTRB(12.0, 40.0, 10.0, 5.0);

  static EdgeInsetsGeometry paddingScreenSH20SV20 =
      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h);
}

class AppRadius {
  static BorderRadius circularRadius = BorderRadius.circular(555.r);
}
