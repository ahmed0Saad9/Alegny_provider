import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

class CardAvatarImage extends StatelessWidget {
  final String image;
  final double size;
  const CardAvatarImage({
    super.key,
    this.size = 32,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.w,
      width: size.w,
      decoration: BoxDecoration(
        color: AppColors.backGroundGrey,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
