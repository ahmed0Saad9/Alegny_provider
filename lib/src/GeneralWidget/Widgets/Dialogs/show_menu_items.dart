import 'package:flutter/material.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

Future<void> showMenuDialog(
    {required BuildContext context,
    required List<PopupMenuEntry<void>> items}) {
  // final RenderObject? overlay = Overlay.of(context).context.findRenderObject();

  // final RenderBox button = context.findRenderObject() as RenderBox;
  return showMenu(
    context: context,
    items: items,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(36.0))),
    position: const RelativeRect.fromLTRB(65.0, 40.0, 0.0, 0.0),
  );
}

class CustomPopupMenuButton extends StatelessWidget {
  final Color? color;
  final List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder;
  const CustomPopupMenuButton({
    required this.itemBuilder,
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: itemBuilder,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      splashRadius: 44,
      offset: const Offset(0, 50),
      elevation: 20,
      child: CircleAvatar(
        radius: 36 / 2,
        backgroundColor: color ?? Colors.transparent,
        child: IconSvg(
          'menu_icon',
          color: color == null ? AppColors.iconBlack : AppColors.iconWight,
        ),
      ),
    );
  }
}

class CustomPopupMenuItemChild extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomPopupMenuItemChild(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon), 8.ESW(), CustomTextL(title)],
    );
  }
}
