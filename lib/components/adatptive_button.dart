import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/loader_widget.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/utils/styles.dart';

class AdaptiveButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final bool? isLoading;
  final bool? isEnabled;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? prefixWidget;
  final EdgeInsets? margin;
  final double? fontSize;

  AdaptiveButton({
    Key? key,
    required this.btnText,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor,
    this.textColor = kWhiteColor,
    this.borderColor,
    this.prefixWidget,
    this.margin,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? LoaderWidget()
        : InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: float12,
                vertical: float10,
              ),
              margin: margin ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: isEnabled == true
                      ? buttonColor ?? kPrimaryColor
                      : kFadedTextColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: borderColor ?? Colors.transparent)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixWidget != null ? prefixWidget! : const SizedBox(),
                  TextComponent(
                    btnText,
                    padding: EdgeInsets.zero,
                    color: textColor,
                    fontSize: fontSize ?? buttonFontSize,
                    fontWeight: buttonFontWeight,
                  ),
                ],
              ),
            ),
          );
  }
}
