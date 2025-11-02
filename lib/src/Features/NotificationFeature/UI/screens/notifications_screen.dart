import 'package:Alegny_provider/src/GeneralWidget/Widgets/Appbars/app_bars.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Other/base_scaffold.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBars.appBarBack(title: 'Notifications'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
