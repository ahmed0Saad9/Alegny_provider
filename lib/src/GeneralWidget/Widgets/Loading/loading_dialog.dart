import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitRipple(
          color: color ?? AppColors.main,
          size: 70.0.w,
        ),
      ),
    );
  }
}

class EasyLoader extends StatelessWidget {
  final Color? color;
  const EasyLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
      width: 100.w,
      color: Colors.transparent,
      child: SpinKitFoldingCube(
        color: color ?? AppColors.main,
        size: 70.0.w,
      ),
    );
  }
}

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors.main,
          size: 22.0.w,
        ),
      ),
    );
  }
}

void setLoading() {
  Get.dialog(
    const Loader(),
    barrierDismissible: false,
  );
}

Widget customLoadingBuilderInImageNetwork(
  BuildContext context,
  Widget child,
  ImageChunkEvent? loadingProgress,
) {
  if (loadingProgress == null) {
    // Image is fully loaded, display it
    return child;
  } else {
    // Image is still loading, show a placeholder or play an animation
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                (loadingProgress.expectedTotalBytes ?? 1)
            : null,
      ),
    );
  }
}

/// loading CachedNetworkImage
class CircularProgressIndicatorWithValue extends StatelessWidget {
  final double? value;
  const CircularProgressIndicatorWithValue({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        value: value,
      ),
    );
  }
}
