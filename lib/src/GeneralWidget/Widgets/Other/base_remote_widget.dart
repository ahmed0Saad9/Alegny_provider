import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/EmptyWidgets/visitor_empty_visits.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Loading/loading_dialog.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/buttons/button_default.dart';
import 'package:Alegny_provider/src/core/constants/app_assets.dart';
import 'package:Alegny_provider/src/core/constants/sizes.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';
import 'package:Alegny_provider/src/core/utils/request_status.dart';

class BaseRemoteWidget extends StatelessWidget {
  final RequestStatus requestStatus;
  final Widget doneWidget;
  final VoidCallback? resendRequest;
  final Widget? initialWidget;
  final Widget? loadingWidget;

  const BaseRemoteWidget({
    Key? key,
    required this.requestStatus,
    this.initialWidget,
    required this.doneWidget,
    this.loadingWidget,
    this.resendRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printDM("RequestStatus is => $requestStatus");
    switch (requestStatus) {
      case RequestStatus.initial:
        {
          return initialWidget ?? 0.ESH();
        }
      case RequestStatus.loading:
        {
          return Center(child: loadingWidget ?? const Loader());
        }
      case RequestStatus.done:
        {
          return doneWidget;
        }
      case RequestStatus.unauthorized:
        return const SizedBox();
      case RequestStatus.connectionError:
        return ConnectionErrorWidget(resendRequest: resendRequest ?? () {});
      case RequestStatus.serverError:
        return const EmptyWidget(
          title: "Error",
        );
    }
  }
}

class ConnectionErrorWidget extends StatelessWidget {
  final VoidCallback resendRequest;

  const ConnectionErrorWidget({
    Key? key,
    required this.resendRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        400.ESH(),
        Padding(
          padding: AppPadding.paddingScreenSH22,
          child: ButtonDefault.main(
            onTap: resendRequest,
            title: "اعاده الارسال",
          ),
        ),
      ],
    );
  }
}
