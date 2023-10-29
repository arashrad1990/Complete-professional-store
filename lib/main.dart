import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';
import 'package:wordpress_app/provider/loding_provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/catalog/catalog.dart';
import 'package:wordpress_app/ui/detailpageshop/detailshop.dart';
import 'package:wordpress_app/ui/home/homepage.dart';
import 'package:wordpress_app/ui/root/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MtState();
}

class _MtState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShopProvider(),
          child: const HomePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LodingProvider(),
          child: const DetailShop(),
        ),
          ChangeNotifierProvider(
          create: (context) => CatalogProvider(),
          child: const CatalogPage(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: RootPage(),
        ),
      ),
    );
  }
}
