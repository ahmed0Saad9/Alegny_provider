import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';

class ErrorBuilderWidget extends StatelessWidget {
  const ErrorBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.errorImage,
        height: 50.h,
        width: 100.w,
      ),
    );
  }
}
