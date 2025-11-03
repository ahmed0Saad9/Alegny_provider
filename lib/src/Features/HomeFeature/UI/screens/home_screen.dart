import 'package:Alegny_provider/src/Features/AddServiceFeature/UI/screens/add_service_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarHome(
        bNBIndex: 0,
      ),
      body: Padding(
        padding: AppPadding.paddingScreenSH16SV16,
        child: Stack(
          children: [
            ListView(
              children: [],
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.main),
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => const AddServiceScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.iconWight,
                      ),
                    ),
                  ),
                  10.ESW(),
                  CustomTextL(
                    'Add_Service',
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
