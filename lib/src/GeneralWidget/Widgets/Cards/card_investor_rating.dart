import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class CardInvestorRating extends StatelessWidget {
  final String name;
  final String profileImageUrl;
  final String reviewText;
  final String reviewDate;
  final int rating;

  const CardInvestorRating({
    super.key,
    required this.name,
    required this.profileImageUrl,
    required this.reviewText,
    required this.reviewDate,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              profileImageUrl,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/Profile.png',
                height: 44.h,
                width: 44.w,
                fit: BoxFit.cover,
              ),
            ),
            16.ESW(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextR(
                  name,
                  fontSize: 14,
                  fontWeight: FW.bold,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return IconSvg(
                      'Star3',
                      color: index < rating
                          ? AppColors.iconGreen
                          : AppColors.iconGray95,
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            const Spacer(),
            CustomTextR.subtitle(
              reviewDate,
              fontSize: 10,
              fontWeight: FW.medium,
              color: AppColors.titleGray95,
            ),
          ],
        ),
        8.ESH(),
        CustomTextR(
          reviewText,
          fontSize: 10,
          color: AppColors.titleGray62,
        ),
      ],
    );
  }
}
