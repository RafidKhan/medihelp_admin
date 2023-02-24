import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/utils/styles.dart';

class BottomSheetComponent extends StatelessWidget {
  String title;
  Widget? listChildren;

  BottomSheetComponent({
    Key? key,
    required this.title,
    this.listChildren,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Column(
        children: [
          TextComponent(
            title,
            padding: const EdgeInsets.symmetric(
                vertical: float20, horizontal: float24),
            fontSize: fontSize20,
            fontWeight: fontWeight500,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration: BoxDecoration(
              color: kFadedTextColor.withOpacity(0.07),
              boxShadow: const [
                defaultBoxShadow,
              ],
            ),
          ),
          listChildren ?? const SizedBox()
        ],
      ),
    );
  }
}
