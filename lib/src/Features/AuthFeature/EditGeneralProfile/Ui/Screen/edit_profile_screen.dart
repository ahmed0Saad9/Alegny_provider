import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Ui/Widgets/edit_profile_TF_body.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/custom_stepper.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/data_success_screen.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/top_custom_container.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/StaggeredAnimations/base_column.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (_) => BaseScaffold(
        backgroundColor: Colors.white,
        appBar: AppBars.appBarBack(title: 'edit_account'),
        body: Padding(
          padding: AppPadding.paddingScreenSH16,
          child: Column(
            children: [
              EditProfileTFBody(
                controller: _,
              ),
              const Spacer(),
              ButtonDefault.main(
                title: 'Confirm',
                active: _.emailController!.text.isNotEmpty &&
                    _.phoneController!.text.isNotEmpty &&
                    _.firstNameController!.text.isNotEmpty &&
                    _.familyNameController!.text.isNotEmpty,
                onTap: () => _.modifiesData(),
              ),
              24.ESH(),
            ],
          ),
        ),
      ),
    );
  }
}
