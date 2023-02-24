import 'package:flutter/material.dart';
import 'package:medihelp_admin/modules/orders/view/tile_view/order_medicine_tile.dart';

class OrderedMedicines extends StatelessWidget {
  List<dynamic> orderData;

  OrderedMedicines({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orderData.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderData.length,
            itemBuilder: (context, index) {
              final mapData = orderData[index];
              return OrderMedicineTile(mapData: mapData);
            })
        : const SizedBox();
  }
}
