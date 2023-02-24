import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/base/base_state.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/models/orders_list_model.dart';
import 'package:medihelp_admin/modules/orders/controller/orders_controller.dart';
import 'package:medihelp_admin/modules/orders/view/tile_view/order_detail.dart';
import 'package:medihelp_admin/modules/orders/view/tile_view/order_tile.dart';
import 'package:medihelp_admin/utils/styles.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends BaseState<OrdersView> {
  final ordersController = Get.put(OrdersController());

  @override
  void initState() {
    // TODO: implement initState
    ordersController.fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(builder: (controller) {
      return DefaultScaffold(
        appBar: const AppbarWidget(
          title: "Add Medicine",
          hideBackButton: true,
        ),
        body: ListView.builder(
            physics: bouncingPhysics,
            itemCount: controller.listOrders.length,
            itemBuilder: (context, index) {
              final OrdersListModel ordersListModel =
                  controller.listOrders[index];
              return OrderTile(
                ordersListModel: ordersListModel,
                viewDetail: () {
                  Get.to(
                    () => OrderDetail(ordersListModel: ordersListModel),
                    transition: defaultPageTransition,
                  );
                },
              );
            }),
      );
    });
  }
}
