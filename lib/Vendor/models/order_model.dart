class OrderModel {
  final String customer;
  final String orderId;
  final String amount;
  String status;

  OrderModel({
    required this.customer,
    required this.orderId,
    required this.amount,
    required this.status,
  });
}
