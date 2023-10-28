import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/models/woocamers/addtocart_requests_model.dart';
import 'package:wordpress_app/models/woocamers/addtocart_response_model.dart';
import 'package:wordpress_app/models/woocamers/product_gategori.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';
import 'package:wordpress_app/models/wordpress/wordpreesmodel.dart';
import 'package:collection/collection.dart';

class ShopProvider with ChangeNotifier {
  ApiService? _apiService;

ShopProvider(){
_apiService = ApiService();
  _iteminCart =[];
}
  bool isLoding = false;
  bool islodingWeblog = false;
//list product all
  List<ProductModel> _prodoctAll = <ProductModel>[];
  List<ProductModel> get product => _prodoctAll;

  Future<void> allProduct() async {
    isLoding = true;
    notifyListeners();
    final List<ProductModel> response = await _apiService!.showAllProduct();
    _prodoctAll = response;
    isLoding = false;
    notifyListeners();
  }

//list shop gategori
  List<ProductGategori> _prodoctAllgategori = <ProductGategori>[];
  List<ProductGategori> get productGategori => _prodoctAllgategori;

  Future<void> allGategori() async {
    isLoding = true;
    notifyListeners();
    final List<ProductGategori> responsegategori =
        await _apiService!.showAllGategori();
    _prodoctAllgategori = responsegategori;
    isLoding = false;
    notifyListeners();
  }

//list shop gategori by id
  List<ProductModel> _prodoctAllgategoribyid = <ProductModel>[];
  List<ProductModel> get productGategoribyid => _prodoctAllgategoribyid;

  Future<void> allGategorByid(String categoryId) async {
    isLoding = true;
    notifyListeners();
    final List<ProductModel> responsegategoribyid =
        await _apiService!.showAllGategoriByid(categoryId);
    _prodoctAllgategoribyid = responsegategoribyid;
    isLoding = false;
    notifyListeners();
  }

// post weblog
  List<WordressModel> _weblogPosts = <WordressModel>[];
  List<WordressModel> get postweblog => _weblogPosts;

  Future<void> weblogPosts() async {
    islodingWeblog = true;
    notifyListeners();
    final List<WordressModel> resonseWeblog = await _apiService!.showPosts();
    _weblogPosts = resonseWeblog;
    islodingWeblog = false;
    notifyListeners();
  }

//List Item Cart
  List<CartItem>? _iteminCart;
  List<CartItem>? get itemsinCart => _iteminCart;

  Future<void> addtoCart(CartProduct product, Function onCallBack) async {
    AddToCartRegModel regModel = AddToCartRegModel();
    regModel.products = <CartProduct>[];

    if (_iteminCart == null) initdata();

    for (var element in _iteminCart!) {
        regModel.products!.add(
          CartProduct(
            productId: element.productId,
            quantity: element.quantity,
          ),
        );
      }

    CartProduct? doblicatedProductId = regModel.products!.firstWhereOrNull(
      (prod) => prod.productId == product.productId,
    );
    if (doblicatedProductId != null) {
      regModel.products!.remove(doblicatedProductId);
    }

    regModel.products!.add(product);

    await _apiService!.addtocart(regModel).then(
      (cartResModel) {
        if (cartResModel.data != null) {
          List<CartItem>? newCartResModle = cartResModel.data;
          _iteminCart = [];
          _iteminCart!.addAll(newCartResModle!);
        }
        onCallBack(regModel);
        notifyListeners();
      },
    );
  }

  void initdata() {
    _apiService = ApiService();
    _iteminCart = <CartItem>[];
  }
}