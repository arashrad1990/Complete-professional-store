import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/addtocart_requests_model.dart';
import 'package:wordpress_app/models/woocamers/cart_response_model.dart';
import 'package:wordpress_app/models/woocamers/login_model.dart';
import 'package:wordpress_app/models/woocamers/order_model.dart';
import 'package:wordpress_app/models/woocamers/product_gategori.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';
import 'package:wordpress_app/models/woocamers/registermodel.dart';
import 'package:wordpress_app/models/woocamers/verify_model.dart';
import 'package:wordpress_app/models/wordpress/wordpreesmodel.dart';
import 'package:wordpress_app/models/zarinpall_verfy.dart';
import 'package:wordpress_app/models/zarinpallmodel.dart';

class ApiService {
  Future<bool> creactEmail(CustomerModel model) async {
    bool returnresponse = false;
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));

    String customers = "https://stokecom.ir/wp-json/wc/v3/customers";
    try {
      Response response = await Dio().post(
        customers,
        data: model.toJson(),
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 201) {
        returnresponse = true;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        returnresponse = false;
      } else {
        returnresponse = false;
      }
    }
    return returnresponse;
  }

  Future<LoginModel> customerLogin(String username, String password) async {
    late LoginModel loginmodel;
    String tokenURL = "https://stokecom.ir/wp-json/jwt-auth/v1/token";
    try {
      Response response = await Dio().post(
        tokenURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        loginmodel = LoginModel.fromJson(response.data);
      } else {
        return LoginModel(message: response.toString());
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          return LoginModel(message: 'هیچ داده ایی دریافت نشد');
        }
        return LoginModel.fromJson(e.response?.data);
      } else {
        return LoginModel(message: e.toString());
      }
    }
    return loginmodel;
  }

  Future<List<ProductModel>> showAllProduct() async {
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    List<ProductModel> productall = <ProductModel>[];
    const String productURL = "https://stokecom.ir/wp-json/wc/v3/products";
    try {
      Response response = await Dio().get(
        productURL,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        productall = (response.data as List)
            .map(
              (v) => ProductModel.fromJson(v),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return productall;
  }

  Future<List<ProductGategori>> showAllGategori() async {
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    List<ProductGategori> productGategoriList = <ProductGategori>[];
    const String productCategoryURL =
        "https://stokecom.ir/wp-json/wc/v3/products/categories";
    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        productGategoriList = (response.data as List)
            .map(
              (v) => ProductGategori.fromJson(v),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return productGategoriList;
  }

  Future<List<ProductModel>> showAllGategoriByid(String idCode) async {
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    List<ProductModel> productGategori = <ProductModel>[];
    String productCategoryURL =
        "https://stokecom.ir/wp-json/wc/v3/products/?category=$idCode";
    try {
      Response response = await Dio().get(
        productCategoryURL,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        productGategori = (response.data as List)
            .map(
              (v) => ProductModel.fromJson(v),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return productGategori;
  }

  Future<List<WordressModel>> showPosts() async {
    List<WordressModel> postWblog = <WordressModel>[];
    const String postURL = "https://stokecom.ir/wp-json/wp/v2/posts?_embed";
    try {
      Response response = await Dio().get(
        postURL,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        postWblog = (response.data as List)
            .map((v) => WordressModel.fromJson(v))
            .toList();
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return postWblog;
  }

//add to cart
  Future<AddToCartResModel> addtocart(AddToCartRegModel model) async {
    model.userId = 1;
    String url = 'https://stokecom.ir/wp-json/wc/v3/addtocart';
    late AddToCartResModel responseModel;

    try {
      Response response = await Dio().post(
        url,
        data: model.toJson(),
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        responseModel = AddToCartResModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw "Error : $e";
      }
    }
    return responseModel;
  }

  Future<List<ProductModel>> getcatalog({
    int? pageNumber,
    int? pageSize,
    String? searchKeyword,
    String? tagName,
    String? sortBy,
    String? sortOrder = 'desc',
  }) async {
    List<ProductModel> productCatalogList = <ProductModel>[];

    try {
      String parameter = '';

      if (searchKeyword != null) {
        parameter += '&search=$searchKeyword';
      }
      if (pageSize != null) {
        parameter += '&per_page=$pageSize';
      }
      if (pageNumber != null) {
        parameter += '&page=$pageNumber';
      }
      if (tagName != null) {
        parameter += '&tag=$tagName';
      }
      if (sortBy != null) {
        parameter += '&orderby=$sortBy';
      }
      if (sortOrder != 'desc') {
        parameter += '&order=asc';
      } else {
        parameter += '&order=desc';
      }

      final String productURL =
          "${WoocommerceInfo.baseURL}${WoocommerceInfo.productURL}?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}${parameter.toString()}";
      Response response = await Dio().get(
        productURL,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        productCatalogList = (response.data as List)
            .map((v) => ProductModel.fromJson(v))
            .toList();
      } else if (response.data == null) {
        throw "اطلاعاتی وجود ندارد";
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return productCatalogList;
  }

  Future<AddToCartResModel> getCartItem() async {
    late AddToCartResModel responseModle;
    int userId = 1;
    final String cartUrl =
        "https://stokecom.ir/wp-json/wc/v3/cart?consumer_key=ck_33e49c4390f6527ee45eb6531000099f028d4962&consumer_secret=cs_ca8a297a94eb76616368e7acdf0f194b0e31ff24&user_id=$userId";
    try {
      Response response = await Dio().get(
        cartUrl,
        options: Options(headers: <String, dynamic>{
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.statusCode == 200) {
        responseModle = AddToCartResModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw "error : $e";
    }
    return responseModle;
  }

  Future<CustomerDetailsModel> getCustomeDetile() async {
    late CustomerDetailsModel responseModle;

    try {
      int userID = 1;
      final String url =
          "${WoocommerceInfo.baseURL}${WoocommerceInfo.customerURL}/$userID?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
      Response response = await Dio().get(
        url,
        options: Options(headers: <String, dynamic>{
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.statusCode == 200) {
        responseModle = CustomerDetailsModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw "error : $e";
    }
    return responseModle;
  }

  Future<CustomerDetailsModel> updateCustomerModel(
      CustomerDetailsModel model) async {
    CustomerDetailsModel? responseModel;

    try {
      int userID = 1;
      String url =
          "${WoocommerceInfo.baseURL}${WoocommerceInfo.customerURL}/$userID?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}";
      Response response = await Dio().post(
        url,
        data: model.toJson(),
        options: Options(headers: <String, dynamic>{
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.statusCode == 200) {
        responseModel = CustomerDetailsModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw "error : $e";
    }
    return responseModel!;
  }

  Future<ZarinpallModel?> getAuthority(String amount) async {
    ZarinpallModel? zarinpallModel;

    try {
      String url = "https://api.zarinpal.com/pg/v4/payment/request.json";
      Map<String, dynamic> parameter = {
        "description": "خرید از سایت استوک",
        "callback_url": ZarinPall().callbackurl,
        "merchant_id": ZarinPall().merchantid,
        'amount': amount,
      };
      Response response = await Dio().post(
        url,
        queryParameters: parameter,
        options: Options(headers: <String, dynamic>{
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.statusCode == 200) {
        zarinpallModel = ZarinpallModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw "error : $e";
    }
    return zarinpallModel;
  }

  Future<ZarinpalVerify?> verfyPeyment(int? amount, String authori) async {
    ZarinpalVerify? zarinPallverify;
    String? amountTorial = '${amount}0';
    try {
      String url = ZarinPall().zarinPallverify;
      Map<String, dynamic> parameter = {
        "merchant_id": ZarinPall().merchantid,
        'amount': amountTorial,
        'authority': authori,
      };
      Response response = await Dio().post(
        url,
        queryParameters: parameter,
        options: Options(headers: <String, dynamic>{
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.statusCode == 200) {
        zarinPallverify = ZarinpalVerify.fromJson(response.data);
      }
    } on DioException catch (e) {
      throw "error : $e";
    }
    return zarinPallverify;
  }

  Future<bool> createOrder(OrderModel model) async {
    model.customerId = 1;

    bool isOrderCreated = false;
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    try {
      Response response =
          await Dio().post(WoocommerceInfo.baseURL + WoocommerceInfo.orderURL,
              data: model.toJson(),
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Basic $authToken',
              }));

      if (response.statusCode == 200) {
        isOrderCreated = true;
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return isOrderCreated;
  }

  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> allOrders = <OrderModel>[];

    try {
      int? userID = 1;
      final String url =
          "${WoocommerceInfo.baseURL}${WoocommerceInfo.orderURL}?consumer_key=${WoocommerceInfo.consumerKey}&consumer_secret=${WoocommerceInfo.consumerSecret}&customer=$userID";
      Response response = await Dio().get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        allOrders = (response.data as List)
            .map(
              (i) => OrderModel.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      throw 'Error $e';
    }
    return allOrders;
  }
}
