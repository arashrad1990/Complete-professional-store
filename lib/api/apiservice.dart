import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/addtocart_requests_model.dart';
import 'package:wordpress_app/models/woocamers/addtocart_response_model.dart';
import 'package:wordpress_app/models/woocamers/login_model.dart';
import 'package:wordpress_app/models/woocamers/product_gategori.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';
import 'package:wordpress_app/models/woocamers/registermodel.dart';
import 'package:wordpress_app/models/wordpress/wordpreesmodel.dart';

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
    String tokenURL = "https://stokecom.ir/wp-json/wc/v3/jwt-auth/v1/token";
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
        throw Exception("اشتباه");
      }
    } on DioException catch (e) {
      throw "Error: $e";
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
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    model.userId = 1;
    String url = "https://stokecom.ir/wp-json/wc/v3/addtocart";
    late AddToCartResModel responseModel;

    try {
      Response response = await Dio().post(
        url,
        data: model.toJson(),
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      debugPrint(response.statusCode.toString());
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

    String pathCatalog = "https://stokecom.ir/wp-json/wc/v3/products";
    String authToken = base64.encode(utf8.encode(
        "${WoocommerceInfo.consumerKey}:${WoocommerceInfo.consumerSecret}"));
    try {
      // ignore: unused_local_variable
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
      Response response = await Dio().get(
        pathCatalog,
        options: Options(
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        productCatalogList = (response.data as List)
            .map((v) => ProductModel.fromJson(v))
            .toList();
      }
    } on DioException catch (e) {
      throw "Error : $e";
    }
    return productCatalogList;
  }
}
