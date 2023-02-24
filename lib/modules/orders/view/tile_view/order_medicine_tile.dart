import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/styles.dart';

class OrderMedicineTile extends StatelessWidget {
  Map<String, dynamic> mapData;

  OrderMedicineTile({
    Key? key,
    required this.mapData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: float10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: float16,
        vertical: float12,
      ),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            "Name: ${mapData['name']}",
            fontSize: float14,
            fontWeight: fontWeight600,
          ),
          TextComponent(
            "Price: ${mapData['price']}",
            fontSize: float14,
            fontWeight: fontWeight400,
          ),
          TextComponent(
            "Quantity: ${mapData['quantity']}",
            fontSize: float14,
            fontWeight: fontWeight400,
          ),
          TextComponent(
            "Pack Total: ${multiplyStrings([
                  mapData['quantity'].toString(),
                  mapData['price'],
                ])}",
            fontSize: float14,
            fontWeight: fontWeight400,
          ),
        ],
      ),
    );
  }
}
