import '../models/product_order_model.dart';

class OrderService {
  static final OrderService _instance = OrderService._();
  OrderService._();
  factory OrderService() {
    return _instance;
  }

  List<ProductOrderModel> _orders = [];

  int get ordersLength => _orders.length;

  List<ProductOrderModel> get getOrders => _orders;

  ProductOrderModel getProductOrder(int index) => _orders[index];

  double get total {
    double _total = 0;
    _orders.forEach((element) {
      _total += element.price * element.quantity;
    });
    return _total;
  }

  addProduct(ProductOrderModel productOrderModel) {
    _orders.add(productOrderModel);
  }

  deleteProduct(int index) {
    _orders.removeAt(index);
  }

  List<Map<String, dynamic>> getOrdersMap() => _orders.map((e) => e.toJson()).toList();




}