import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class FavoritePage extends StatefulWidget {
  final ProductModel? data;
  const FavoritePage({super.key, this.data});

  @override
  State<FavoritePage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<FavoritePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider shopProvider =
          Provider.of<ShopProvider>(context, listen: false);
      shopProvider.allProduct();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Text("favorite"),
      )),
    );
  }
}
