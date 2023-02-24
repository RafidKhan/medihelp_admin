import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/models/orders_list_model.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';

class OrdersController extends GetxController {
  List<OrdersListModel> listOrders = <OrdersListModel>[];

  Future<void> fetchOrders() async {
    listOrders.clear();
    try {
      await FirebaseFirestore.instance
          .collection(TableOrders.collectionName)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((element) {
            OrdersListModel ordersListModel =
                OrdersListModel.fromJson(element.data());
            listOrders.add(ordersListModel);
          });

          update();
        }
      });
    } catch (e) {
      snackBarWidget(title: "Error loading orders", subTitle: "");
    }
  }

  Future<void> updateOrder({required OrdersListModel ordersListModel}) async {
    try {
      showLoaderAlert();
      await FirebaseFirestore.instance
          .collection(TableOrders.collectionName)
          .doc(ordersListModel.orderId)
          .update(ordersListModel.toJson());
      Get.back();
      snackBarWidget(title: "Order has been updated", subTitle: "");
      update();
    } catch (e) {
      Get.back();
      snackBarWidget(title: "Failed to update order", subTitle: "");
      throw e;
    }
  }
}
