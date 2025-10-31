import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/BottomNavigationBar/base_icon_widget.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/BottomNavigationBar/base_tabs_widget.dart';

import '../../Bloc/Controller/base_BNB_controller.dart';
import '../../Bloc/Model/base_BNB_model.dart';

class BaseBNBScreen extends StatelessWidget {
  const BaseBNBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseNBNController());
    // Get.put(ToggleFavController(),permanent: true);
    return GetBuilder<BaseNBNController>(
      builder: (_) => WillPopScope(
        onWillPop: _.willPopCallback,
        child: Scaffold(
          // appBar: _.bottomNavIndex == 3
          //     ? null
          //     : AppBars.appBarHome(
          //         title:
          //         adminBaseModels[_.bottomNavIndex].title,
          //         bNBIndex: _.bottomNavIndex),
          body: Column(
            children: [
              Expanded(
                child: adminBaseModels[_.bottomNavIndex].child,
              ),
              BaseTabsWidget(
                children: adminBaseModels
                    .map(
                      (e) => Expanded(
                        child: BaseIconWidget(
                          icon: e.icon,
                          title: e.title,
                          onTap: () {
                            _.updateIndex(e.id);
                          },
                          active: _.bottomNavIndex == e.id,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
