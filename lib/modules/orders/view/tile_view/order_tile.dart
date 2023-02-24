import 'package:flutter/material.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/models/orders_list_model.dart';
import 'package:medihelp_admin/utils/styles.dart';

class OrderTile extends StatelessWidget {
  OrdersListModel ordersListModel;
  VoidCallback viewDetail;

  OrderTile({
    Key? key,
    required this.ordersListModel,
    required this.viewDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: float12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: float12,
      ),
      decoration: BoxDecoration(
        color: kCardColorLite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            "Order ID: ${ordersListModel.orderId ?? ""}",
            fontSize: fontSize14,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.symmetric(
              vertical: float5,
            ),
          ),
          TextComponent(
            "Order Status: ${ordersListModel.orderStatus ?? ""}",
            fontSize: fontSize14,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.symmetric(
              vertical: float5,
            ),
          ),
          TextComponent(
            "Total Amount: ${ordersListModel.totalPrice ?? ""} BDT",
            fontSize: fontSize14,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            padding: const EdgeInsets.symmetric(
              vertical: float5,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextComponent(
              "View Detail",
              fontSize: fontSize10,
              textOverflow: TextOverflow.ellipsis,
              color: kPrimaryColor,
              textDecoration: TextDecoration.underline,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.symmetric(
                vertical: float5,
              ),
              onPressed: viewDetail
            ),
          ),
        ],
      ),
    );
  }
}
