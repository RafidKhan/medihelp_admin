import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp_admin/components/app_bar_widget.dart';
import 'package:medihelp_admin/components/common_button.dart';
import 'package:medihelp_admin/components/default_scaffold.dart';
import 'package:medihelp_admin/components/selectable_textfield.dart';
import 'package:medihelp_admin/components/text_component.dart';
import 'package:medihelp_admin/models/orders_list_model.dart';
import 'package:medihelp_admin/models/user_model.dart';
import 'package:medihelp_admin/modules/orders/controller/orders_controller.dart';
import 'package:medihelp_admin/modules/orders/view/tile_view/ordered_medicines.dart';
import 'package:medihelp_admin/modules/orders/view/tile_view/user_data_view.dart';
import 'package:medihelp_admin/utils/common_methods.dart';
import 'package:medihelp_admin/utils/firebase_constants.dart';
import 'package:medihelp_admin/utils/styles.dart';

import '../../../../components/bottom_sheet_component.dart';

class OrderDetail extends StatefulWidget {
  OrdersListModel ordersListModel;

  OrderDetail({Key? key, required this.ordersListModel}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final ordersController = Get.put(OrdersController());
  UserModel? userModel;
  String orderStatus = "";

  @override
  void initState() {
    // TODO: implement initState
    orderStatus = widget.ordersListModel.orderStatus ?? "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchUserData();
    });
    super.initState();
  }

  fetchUserData() async {
    userModel = await getUserData(widget.ordersListModel.orderBy ?? "");
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: const AppbarWidget(
        title: "Order Detail",
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float12,
        ),
        child: SingleChildScrollView(
          physics: bouncingPhysics,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                "Order ID: ${widget.ordersListModel.orderId ?? ""}",
                fontSize: fontSize16,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                padding: const EdgeInsets.symmetric(
                  vertical: float5,
                ),
              ),
              TextComponent(
                "Total Amount: ${widget.ordersListModel.totalPrice ?? ""} BDT",
                fontSize: fontSize16,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                padding: const EdgeInsets.symmetric(
                  vertical: float5,
                ),
              ),
              OrderedMedicines(
                orderData: widget.ordersListModel.orderData ?? [],
              ),
              const TextComponent(
                "Order Status:",
                fontSize: fontSize16,
                fontWeight: fontWeight700,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                padding: EdgeInsets.symmetric(
                  vertical: float5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: float5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SelectableTextField(
                        text: orderStatus,
                        hintText: "Order Status",
                        padding: const EdgeInsets.symmetric(
                          horizontal: float10,
                          vertical: float12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return BottomSheetComponent(
                              title: "Select Category",
                              listChildren: Expanded(
                                child: ListView.separated(
                                    itemCount: orderStatusList.length,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final String element =
                                          orderStatusList[index];
                                      return InkWell(
                                        onTap: () {
                                          orderStatus = element;
                                          Get.back();
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextComponent(
                                            element,
                                            textAlign: TextAlign.start,
                                            fontSize: fontSize16,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: horizontalMargin,
                                              vertical: float10,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    }),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
              userModel != null
                  ? UserDataView(userModel: userModel!)
                  : const SizedBox(),
              CommonButton(
                btnText: "Update Order",
                margin: const EdgeInsets.symmetric(
                  vertical: float12,
                ),
                onTap: () {
                  widget.ordersListModel.orderStatus = orderStatus.trim();
                  ordersController.updateOrder(
                    ordersListModel: widget.ordersListModel,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
