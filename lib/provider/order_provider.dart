import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/models/woocamers/order_model.dart';

class OrderProvider with ChangeNotifier {
  bool isLoading = false;
  late ApiService _apiService;

  List<OrderModel>? _orderList;
  List<OrderModel>? get allOrders => _orderList;
  double get totalOrders => _orderList!.length.toDouble();

  OrderProvider() {
    initializeData();
  }

  initializeData() {
    _apiService = ApiService();
  }

  fetchOrders() async {
    isLoading = true;
    notifyListeners();
    List<OrderModel> orderList = await _apiService.getAllOrders();
    _orderList ??= <OrderModel>[];
    if (orderList.isNotEmpty) {
      _orderList = [];
      _orderList!.addAll(orderList);
    }
    isLoading = false;
    notifyListeners();
  }
}
