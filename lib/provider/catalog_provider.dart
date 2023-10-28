import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/catalog/catalog_class.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';

enum DataStatus {
  initial,
  loading,
  stable,
}

class CatalogProvider with ChangeNotifier {
  late ApiService _apiService;
  late List<ProductModel> _productlist;
  late SortBy _sortBy;
  DataStatus _dataStatus = DataStatus.stable;
  int pageSize = 5;

  List<ProductModel> get allProduct => _productlist;
  double get totalProduct => _productlist.length.toDouble();

  initializeData() {
    _apiService = ApiService();
    _productlist = <ProductModel>[];
  }

  CatalogProvider() {
    initializeData();
    _sortBy = SortBy('popularity', 'latest', 'asc');
  }

  getStatus() => _dataStatus;

  setLoadingStatus(DataStatus dataStatus) {
    _dataStatus = dataStatus;
  }

  setSortOlder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fatchProducts(
    pageNumber, {
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String? sortOlder = 'desc',
  }) async {
    List<ProductModel> itemModel = await _apiService.getcatalog(
      searchKeyword: searchKeyword,
      pageNumber: pageNumber,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder.toString(),
      tagName: tagName,
      pageSize: pageSize,
    );
    if (itemModel.isNotEmpty) {
      _productlist.addAll(itemModel);
    }
    setLoadingStatus(DataStatus.stable);
  }
}
