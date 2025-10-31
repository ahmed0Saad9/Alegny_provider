import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Alegny_provider/src/GeneralWidget/Widgets/Text/custom_text.dart';
import 'package:Alegny_provider/src/core/constants/color_constants.dart';
import 'package:Alegny_provider/src/core/services/svg_widget.dart';
import 'package:Alegny_provider/src/core/utils/extensions.dart';

enum FieldType {
  withBorder,
  withOutBorder,
}

enum SecureType {
  never,
  toggle,
  always,
}

class TextFieldDefault extends StatefulWidget {
  final double? fieldHeight;
  final String hint;
  final String? label;
  final String upperTitle;
  final FieldType fieldType;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Widget? suffixWidget;
  final IconData? icon;
  final String? prefixIconUrl;
  final Widget? prefixIconWidget;
  final double prefixIconSize;
  final String? suffixIconUrl;
  final bool? isPrefixIcon;
  final bool? isSuffixIcon;
  final String? Function(String?)? validation;
  final Function(String)? onChanged;
  final VoidCallback? onComplete;
  final FormFieldSetter<String>? onSaved;
  final bool isSuffixWidget;
  final Color hintColor;
  final Color? labelColor;
  final Color titleColor;
  final Color errorColor;
  final Color fieldColor;
  final Color filledColor;
  final Color enableBorder;
  final Color disableBorder;
  final Color focusBorder;
  final Color errorBorder;
  final Color cursorColor;
  final Color? prefixColor;
  final Color suffixColor;
  final Color iconColor;

  final String? errorText;
  final String? errorLargeText;
  final String? errorMinimumText;
  final int largeCondition;
  final int minimumCondition;
  final int maxLines;
  final int? maxLength;

  final TextEditingController? controller;

  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onSuffixTap;

  final double borderRadius;
  final double borderWidth;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final SecureType secureType;

  final double outerVerticalPadding;
  final double outerHorizontalPadding;
  final bool enable;
  final Color upperTitleColor;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  TextFieldDefault({
    super.key,
    this.hint = '',
    this.controller,
    this.onTap,
    this.focusNode,
    this.upperTitle = '',
    this.upperTitleColor = AppColors.titleMain,
    this.label,
    this.fieldType = FieldType.withBorder,
    this.prefixIconData,
    this.suffixIconData,
    this.prefixIconWidget,
    this.prefixIconUrl,
    this.prefixIconSize = 24,
    this.suffixIconUrl,
    this.isPrefixIcon = false,
    this.isSuffixIcon = false,
    this.isSuffixWidget = false,
    this.suffixWidget,
    this.fieldHeight,
    this.validation,
    this.onChanged,
    this.onComplete,
    this.onSaved,
    this.maxLines = 1,
    this.maxLength,
    this.enable = true,
    this.hintColor = TextFieldColors.hintTitle,
    this.labelColor = TextFieldColors.mainTitle,
    this.titleColor = TextFieldColors.mainTitle,
    this.errorColor = TextFieldColors.errorText,
    this.fieldColor = TextFieldColors.backGroundWhite,
    this.filledColor = TextFieldColors.backGroundWhite,
    this.enableBorder = TextFieldColors.enableBorder,
    this.disableBorder = TextFieldColors.disableBorder,
    this.focusBorder = TextFieldColors.focusBorder,
    this.errorBorder = TextFieldColors.errorBorder,
    this.cursorColor = TextFieldColors.cursor,
    this.errorText,
    this.errorLargeText,
    this.largeCondition = 0,
    this.minimumCondition = 0,
    this.errorMinimumText,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 18.0,
    this.icon,
    this.onSuffixTap,
    this.prefixColor = TextFieldColors.icon,
    this.suffixColor = TextFieldColors.suffixIcon,
    this.iconColor = TextFieldColors.icon,
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.keyboardType,
    this.textInputAction,
    this.secureType = SecureType.never,
    this.outerVerticalPadding = 0.0,
    this.outerHorizontalPadding = 0.0,
  });

  @override
  _TextFieldDefaultState createState() => _TextFieldDefaultState();
}

class _TextFieldDefaultState extends State<TextFieldDefault> {
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool secureState = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.outerVerticalPadding.h,
        horizontal: widget.outerHorizontalPadding.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drawUpperTitle(
              upperTitleText: widget.upperTitle,
              usedUpperTitleColor: widget.upperTitleColor),
          InkWell(
            onTap: widget.onTap != null
                ? () {
                    widget.onTap!();
                  }
                : null,
            child: TextFormField(
              // onTapOutside: (event)=> FocusScope.of(context).unfocus(),
              // onTap: widget.onTap != null
              //     ? () {
              //         printDM("onTap --------------------");
              //         widget.onTap!();
              //       }
              //     : null,

              obscureText: widget.secureType == SecureType.never
                  ? false
                  : widget.secureType == SecureType.always
                      ? true
                      : secureState,

              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              focusNode: _focusNode,
              onEditingComplete: widget.onComplete,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              controller: widget.controller,
              cursorColor: widget.cursorColor,
              // ignore: missing_return
              enabled: widget.enable,
              maxLength: widget.maxLength,
              maxLines: widget.maxLines,
              validator: widget.validation ??
                  (value) {
                    if (value!.isEmpty) {
                      return widget.errorText;
                    } else if (value.length < widget.minimumCondition) {
                      return widget.errorMinimumText;
                    }
                    if (widget.largeCondition != 0) {
                      if (value.length > widget.largeCondition) {
                        return widget.errorLargeText;
                      }
                    } else {
                      return null;
                    }
                    return null;
                  },
              style: TextStyle(
                fontSize: 16.sp,
                color: widget.titleColor,
                fontFamily: "Regular",
              ),
              decoration: InputDecoration(
                enabled: true,
                filled: true,
                fillColor: widget.filledColor,
                // HINT TEXT WITH STYLE
                hintText: widget.hint.tr,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: widget.hintColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Regular",
                ),
                // LABEL TEXT WITH STYLE
                labelText: widget.label == null ? null : widget.label!.tr,
                labelStyle: TextStyle(
                  fontSize: 16.r,
                  color: widget.labelColor,
                  fontFamily: "Regular",
                ),
                // ERROR TEXT STYLE
                errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 12.r,
                    color: widget.errorColor,
                    fontFamily: "ExtraLight"),
                // PADDING
                contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding.h,
                  horizontal: widget.horizontalPadding.w,
                ),
                icon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 24.w,
                      )
                    : null,
                prefixIcon: (widget.prefixIconWidget != null)
                    ? widget.prefixIconWidget
                    : (widget.prefixIconUrl != null ||
                            widget.prefixIconData != null)
                        ? widget.prefixIconUrl != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  10.ESW(),
                                  IconSvg(
                                    widget.prefixIconUrl!,
                                    color: _isFocused
                                        ? AppColors.main
                                        : TextFieldColors.icon,
                                  ),
                                  5.ESW(),
                                ],
                              )
                            : Icon(
                                widget.prefixIconData,
                                color: widget.prefixColor,
                                size: 24.w,
                              )
                        : null,
                // constraints: BoxConstraints(
                //   maxHeight: 54.h,
                //   minHeight:54.h,
                // ),
                prefixIconConstraints: widget.prefixIconUrl == null
                    ? null
                    : BoxConstraints(
                        maxHeight: 24.h,
                        maxWidth: 70.w,
                      ),
                suffixIcon: widget.secureType == SecureType.toggle
                    ? IconButton(
                        icon: Icon(secureState
                            ? Icons.visibility
                            : Icons.visibility_off_sharp),
                        color: widget.suffixColor,
                        iconSize: 20.w,
                        onPressed: () {
                          setState(() {
                            secureState = !secureState;
                          });
                        })
                    : widget.isSuffixWidget
                        ? widget.suffixWidget
                        : (widget.suffixIconData != null)
                            ? IconButton(
                                icon: Icon(
                                  widget.suffixIconData,
                                  color: widget.suffixColor,
                                  size: 24.w,
                                ),
                                onPressed: () {
                                  widget.onSuffixTap!();
                                })
                            : (widget.suffixIconUrl != null)
                                ? IconSvg(
                                    widget.suffixIconUrl!,
                                    size: 16,
                                    color: widget.suffixColor,
                                  )
                                : null,
                border: widget.fieldType == FieldType.withBorder
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                            color: widget.enableBorder,
                            width: widget.borderWidth.w
                            //style: BorderStyle.solid,
                            ),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.errorBorder,
                            width: widget.borderWidth.w),
                      ),
                disabledBorder: widget.fieldType == FieldType.withBorder
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                            color: widget.disableBorder,
                            width: widget.borderWidth.w),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.disableBorder,
                            width: widget.borderWidth.w),
                      ),
                enabledBorder: widget.fieldType == FieldType.withBorder
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                            color: widget.enableBorder,
                            width: widget.borderWidth.w),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.enableBorder,
                            width: widget.borderWidth.w),
                      ),
                focusedBorder: widget.fieldType == FieldType.withBorder
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                            color: widget.focusBorder,
                            width: widget.borderWidth.w),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.focusBorder,
                            width: widget.borderWidth.w),
                      ),
                errorBorder: widget.fieldType == FieldType.withBorder
                    ? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(
                            color: widget.errorBorder,
                            width: widget.borderWidth.w),
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: widget.errorBorder,
                            width: widget.borderWidth.w),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawUpperTitle(
      {String upperTitleText = '', Color? usedUpperTitleColor}) {
    return widget.upperTitle.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CustomTextL(
              widget.upperTitle,
              color: usedUpperTitleColor,
              isOverFlow: true,
            ),
          )
        : const SizedBox(
            height: 0,
          );
  }
}
