import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

import '../../../core/constants/color_constants.dart';

class CardBusinessesIncubator extends StatelessWidget {
  const CardBusinessesIncubator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.borderGreyE1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 186.w,
                child: CustomTextR.header(
                    'مشروع متجر إلكتروني لبيع منتجات صحية وعضوية',
                    fontSize: 14),
              ),
              Spacer(),
            ],
          ),
          15.ESH(),
          CustomTextR(
            'للعناية بالبشرة والشعر هو فكرة رائعة ومطلوبة خاصة في الوقت الحالي حيث يزداد الاهتمام بالعناية بالجمال بشكل كبير. لإطلاق هذا المشروع',
            color: AppColors.titleGray54,
          ),
          16.ESH(),
        ],
      ),
    );
  }
}
