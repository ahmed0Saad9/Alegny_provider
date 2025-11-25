import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Ui/Widgets/edit_profile_TF_body.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) => BaseScaffold(
        backgroundColor: Colors.white,
        appBar: AppBars.appBarBack(title: 'edit_account'),
        body: controller.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: AppPadding.paddingScreenSH16,
                child: ListView(
                  children: [
                    EditProfileTFBody(controller: controller),
                    230.ESH(),
                    ButtonDefault.main(
                      title: 'Confirm',
                      onTap: () => controller.editProfile(),
                    ),
                    24.ESH(),
                  ],
                ),
              ),
      ),
    );
  }
}
