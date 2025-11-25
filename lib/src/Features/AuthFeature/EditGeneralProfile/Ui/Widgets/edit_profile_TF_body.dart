import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/avatar_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_phone.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/custom_stepper.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/top_custom_container.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/validator.dart';

class EditProfileTFBody extends StatelessWidget {
  final EditProfileController controller;

  const EditProfileTFBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return SizedBox(
      width: Get.width,
      child: Form(
        key: controller.globalKey,
        child: BaseStaggeredColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.ESH(),
            Center(
              child: Stack(
                children: [
                  Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: AvatarWidget(
                          image: controller.imageLocal,
                          imageFile: controller.image?.media,
                          height: 100,
                          width: 100,
                        ),
                      )),
                  Positioned(
                    bottom: 0.h,
                    right: 0.w,
                    child: InkWell(
                      onTap: () {
                        controller.setImageFromGallery();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16.sp,
                          color: AppColors.main,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            32.ESH(),
            Row(
              children: [
                Expanded(
                  child: TextFieldDefault(
                    label: 'First_Name',
                    prefixIconUrl: 'Profile',
                    controller: controller.firstNameController,
                    validation: nameValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                ),
                10.ESW(),
                Expanded(
                  child: TextFieldDefault(
                    label: 'Family_Name',
                    prefixIconUrl: 'Profile',
                    controller: controller.lastNameController,
                    validation: nameValidator,
                    onComplete: () {
                      node.nextFocus();
                    },
                  ),
                ),
              ],
            ),
            24.ESH(),
            TextFieldDefault(
              label: 'Email',
              prefixIconUrl: 'Email',
              controller: controller.emailController,
              validation: emailValidator,
              keyboardType: TextInputType.emailAddress,
              onComplete: () {
                node.nextFocus();
              },
            ),
            24.ESH(),
            TextFieldPhone(
              node: node,
              controller: controller.phoneController,
              onCountryChanged: (p0) {},
              initialCountryCode: '+20',
            ),
          ],
        ),
      ),
    );
  }
}
