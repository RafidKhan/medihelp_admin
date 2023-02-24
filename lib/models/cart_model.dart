class CartModel {
  final String name;
  final String id;
  final String price;
  int quantity;

  CartModel(
      {required this.name,
      required this.id,
      required this.price,
      required this.quantity});

  CartModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        id = json['id'] ?? "",
        price = json['price'] ?? 0,
        quantity = json['quantity'] ?? "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'price': price,
        'quantity': quantity,
      };
}
