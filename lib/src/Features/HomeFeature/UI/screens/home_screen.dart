import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/controller/subjects_controller.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/academic_year_model.dart';
import 'package:Alegny_provider/src/Features/HomeFeature/Bloc/model/subjects_model.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';

import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_search.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);
    return GetBuilder<SubjectsController>(
      init: SubjectsController(),
      builder: (_) => Container(
        color: AppColors.scaffoldBackGround,
        child: Stack(
          children: [
            Image.asset('assets/images/HomeScreenBG.png'),
            BaseScaffold(
              backgroundColor: AppColors.transparentColor,
              appBar: AppBars.appBarHome(
                bNBIndex: 0,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.ESH(),
                  Padding(
                    padding: AppPadding.paddingScreenSH36,
                    child: SearchTextField(
                        node: node,
                        searchController: _.searchController,
                        onChanged: (value) {
                          _.debounceSearch();
                        },
                        onComplete: () {
                          node.unfocus();
                          _.getSubjects();
                        },
                        hint: 'Search_lecture_name'),
                  ),
                  32.ESH(),
                  Expanded(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [],
                    ),
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
