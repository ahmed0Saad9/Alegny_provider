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

import '../../../../../core/services/svg_widget.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.ESH(),
            TextFieldDefault(
              label: 'Full_Name',
              controller: controller.fullNameController,
              validation: emptyValidator,
              onComplete: () {
                node.nextFocus();
              },
            ),
            16.ESH(),
            TextFieldDefault(
              label: 'Email',
              controller: controller.emailController,
              validation: emailValidator,
              keyboardType: TextInputType.emailAddress,
              onComplete: () {
                node.nextFocus();
              },
            ),
            16.ESH(),
          ],
        ),
      ),
    );
  }
}
