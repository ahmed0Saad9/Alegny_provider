import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/color_constants.dart';
import '../Text/custom_text.dart';

class SingleChoseRowForm extends StatelessWidget {
  final String title;
  final String? image;
  final bool isSelected;
  final bool? bottomLine;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback onTap;

  const SingleChoseRowForm({
    this.image,
    required this.title,
    required this.isSelected,
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.onTap,
    this.bottomLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        // height: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: bottomLine!
                    ? Colors.black.withOpacity(0.12)
                    : Colors.transparent),
          ),
        ),
        width: Get.width,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (image != null) ...[
              SizedBox(
                height: 20,
                width: 30,
                child: Image.network(
                  image!,
                  height: 20,
                  width: 30,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.error_outline,
                  ),
                ),
              ).paddingSymmetric(horizontal: 6.w)
            ],
            Expanded(
              child: CustomTextL(
                title,
                fontSize: 14,
                fontWeight: FW.medium,
                maxLines: 1,
                isOverFlow: true,
                textAlign: TextAlign.start,
                padding: EdgeInsets.symmetric(vertical: 6.h),
              ),
            ),
            8.ESW(),
            SingleChoseCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class SingleChoseCircle extends StatelessWidget {
  const SingleChoseCircle({
    Key? key,
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.w,
      width: 16.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          width: 2.w,
          color: isSelected ? AppColors.main : AppColors.borderGrey75,
        ),
      ),
      child: isSelected == false
          ? 0.0.ESH()
          : Center(
              child: Container(
                height: 8.w,
                width: 8.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.main
                      : AppColors.singleChoseCircleUnSelected,
                  shape: BoxShape.circle,
                ),
              ),
            ),
    );
  }
}
