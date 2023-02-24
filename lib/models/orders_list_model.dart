class OrdersListModel {
  String? orderStatus;
  int? totalPrice;
  List<dynamic>? orderData;
  String? orderBy;
  String? orderId;

  OrdersListModel({
    this.orderStatus,
    this.totalPrice,
    this.orderData,
    this.orderBy,
    this.orderId,
  });

  OrdersListModel.fromJson(Map<String, dynamic> json)
      : orderStatus = json['order_status'] as String?,
        totalPrice = json['totalPrice'] as int?,
        orderBy = json['order_by'] as String?,
        orderId = json['order_id'] as String?,
        orderData = json['order_data'] ?? [];

  Map<String, dynamic> toJson() => {
        'order_status': orderStatus,
        'totalPrice': totalPrice,
        'order_data': orderData,
        'order_by': orderBy,
        'order_id': orderId
      };
}
