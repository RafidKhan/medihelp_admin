import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/utils/styles.dart';

class SelectableTextField extends StatelessWidget {
  String? text;
  String hintText;
  Widget? prefix;
  Widget? suffix;
  EdgeInsets? margin;
  EdgeInsets? padding;
  VoidCallback? onTap;

  SelectableTextField({
    Key? key,
    this.text,
    required this.hintText,
    this.suffix,
    this.prefix,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: float16,
              vertical: float10,
            ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: kTextFieldBorder,
            )),
        child: Center(
          child: Row(
            children: [
              prefix ?? const SizedBox(),
              TextComponent(
                text ?? hintText,
                padding: const EdgeInsets.symmetric(
                  horizontal: float10,
                ),
                fontSize: fontSize16,
                fontWeight: text != null ? fontWeight600 : fontWeight400,
                color: text != null ? kBlackColor : kFadedTextColor,
              ),
              const Spacer(),
              suffix ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
