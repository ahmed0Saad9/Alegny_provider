import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';

enum FW {
  bold,
  medium,
  light,
  regular,
}

enum CustomTextDecoration {
  none,
  lineThrough,
  underLine,
  overLine,
  // combine,
}

class CustomTextL extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final double? letterSpacing;
  final bool isBold;
  final bool textShadow;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final CustomTextDecoration decoration;
  final TextAlign? textAlign;
  final FW fontWeight;

  const CustomTextL(
    this.label, {
    Key? key,
    this.color = AppColors.titleMain,
    this.fontSize = 20,
    this.fontWeight = FW.regular,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration = CustomTextDecoration.none,
    this.textHeight,
    this.textAlign,
    this.textShadow = false,
    this.backgroundColor,
    this.letterSpacing,
  }) : super(key: key);

  /// Build Subtitle Text

  factory CustomTextL.subtitle(
    String label, {
    Key? key,
    Color color = AppColors.titleSub,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 14,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign = TextAlign.start,
    FW fontWeight = FW.regular,
  }) =>
      CustomTextL(
        label.tr,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        backgroundColor: backgroundColor,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  // build title text
  factory CustomTextL.title(
    String label, {
    Key? key,
    Color color = AppColors.titleMain,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 20.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.bold,
  }) =>
      CustomTextL(
        label.tr,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        backgroundColor: backgroundColor,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  /// Build Header Text

  factory CustomTextL.header(
    String label, {
    Key? key,
    double fontSize = 28,
    FW fontWeight = FW.bold,
    Color color = AppColors.titleMain,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = true,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
  }) =>
      CustomTextL(
        label.tr,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        (isUpperCase ? label.tr.toUpperCase() : label.tr).replaceAll("_", " "),

        /// adaptive arabic nums ///TODO/ update when eng sub ends
        textScaleFactor: 1,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              fontSize: (fontSize ?? 16).sp,
              decoration: _getTextDecoration(decoration),
              //TextDecoration.combine(decorations),

              height: textHeight,
              letterSpacing: letterSpacing,
              fontFamily: getFontFamily(fontWeight),
              shadows: textShadow
                  ? [
                      const Shadow(
                        blurRadius: 0.8,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      )
                    ]
                  : null,
            ),
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
      ),
    );
  }
}

class CustomTextR extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final double? letterSpacing;
  final bool isBold;
  final bool textShadow;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final CustomTextDecoration decoration;
  final TextAlign? textAlign;
  final FW fontWeight;

  const CustomTextR(
    this.label, {
    Key? key,
    this.color = AppColors.titleMain,
    this.fontSize = 20,
    this.fontWeight = FW.regular,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration = CustomTextDecoration.none,
    this.textHeight,
    this.textAlign,
    this.textShadow = false,
    this.backgroundColor,
    this.letterSpacing,
  }) : super(key: key);

  /// Build Subtitle Text

  factory CustomTextR.subtitle(
    String label, {
    Key? key,
    Color color = AppColors.titleGray65,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    double fontSize = 14.0,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
    FW fontWeight = FW.regular,
  }) =>
      CustomTextR(
        label,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        backgroundColor: backgroundColor,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  /// Build Header Text

  factory CustomTextR.header(
    String label, {
    Key? key,
    double fontSize = 20.0,
    FW fontWeight = FW.bold,
    Color color = AppColors.titleBlack25,
    Color? backgroundColor,
    bool isUpperCase = false,
    bool isBold = false,
    CustomTextDecoration decoration = CustomTextDecoration.none,
    int? maxLines,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    TextAlign? textAlign,
  }) =>
      CustomTextR(
        label,
        decoration: decoration,
        key: key,
        isUpperCase: isUpperCase,
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        isOverFlow: isOverFlow,
        isBold: isBold,
        padding: padding,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        (isUpperCase ? label.toUpperCase() : label).replaceAll("_", " "),

        /// adaptive arabic nums ///TODO/ update when eng sub ends
        textScaleFactor: 1,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: color,
              backgroundColor: backgroundColor,
              fontSize: (fontSize ?? 16).sp,
              decoration: _getTextDecoration(decoration),
              //TextDecoration.combine(decorations),
              height: textHeight,
              letterSpacing: letterSpacing,
              fontFamily: getFontFamily(fontWeight),
              shadows: textShadow
                  ? [
                      const Shadow(
                        blurRadius: 0.8,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      )
                    ]
                  : null,
            ),
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
      ),
    );
  }
}

String getFontFamily(FW fw) {
  switch (fw) {
    case FW.bold:
      return "Bold";
    case FW.medium:
      return "Medium";
    case FW.light:
      return "Light";
    case FW.regular:
      return 'Regular';
    default:
      return 'Regular';
  }
}

TextDecoration _getTextDecoration(CustomTextDecoration decoration) {
  switch (decoration) {
    case CustomTextDecoration.none:
      return TextDecoration.none;
    case CustomTextDecoration.lineThrough:
      return TextDecoration.lineThrough;
    case CustomTextDecoration.underLine:
      return TextDecoration.underline;
    case CustomTextDecoration.overLine:
      return TextDecoration.overline;
    // case CustomTextDecoration.combine:
    //   return TextDecoration.combine([
    //     TextDecoration.none,
    //   ]);
  }
}
