import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/TextFields/text_field_default.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.node,
    this.searchController,
    this.onChanged,
    required this.onComplete,
    required this.hint,
    this.onTap,
    this.enable = true,
  });

  final FocusScopeNode node;
  final String hint;
  final TextEditingController? searchController;
  final dynamic Function(String)? onChanged;
  final VoidCallback onComplete;
  final VoidCallback? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFieldDefault(
      enable: enable,
      hint: hint,
      borderRadius: 22.r,
      horizontalPadding: 0,
      outerHorizontalPadding: 0,
      verticalPadding: 0,
      outerVerticalPadding: 0,
      enableBorder: TextFieldColors.enableBorder,
      // enableBorder: TextFieldColors.hintTitle,
      // filledColor: TextFieldColors.backGround,
      isSuffixWidget: true,
      prefixIconWidget: IconButton(
        onPressed: () {
          node.unfocus();
          onComplete();
        },
        icon: const IconSvg(
          'SearchIcon',
          size: 18,
          boxFit: BoxFit.fill,
        ),
      ),
      controller: searchController,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      onTap: onTap,
      onComplete: () {
        node.unfocus();
        onComplete();
      },
    );
  }
}
