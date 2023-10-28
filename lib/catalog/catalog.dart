import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/catalog/catalog_class.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/catalog_provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
  int page = 1;
  final TextEditingController searchQury = TextEditingController();
  Timer? _debouns;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      CatalogProvider productList =
          Provider.of<CatalogProvider>(context, listen: false);
      productList.initializeData();
      productList.setLoadingStatus(DataStatus.initial);
      productList.fatchProducts(page);
    });
    searchQury.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    CatalogProvider productList =
        Provider.of<CatalogProvider>(context, listen: false);
    if (_debouns?.isActive ?? false) _debouns!.cancel();

    _debouns = Timer(const Duration(milliseconds: 900), () {
      productList.initializeData();
      productList.setLoadingStatus(DataStatus.initial);
      productList.fatchProducts(page, searchKeyword: searchQury.text);
    });
  }

  final sortByOption = [
    SortBy('popularity', 'محبوبت', 'asc'),
    SortBy('date', 'قدیمی ترین', 'asc'),
    SortBy('price', 'قیمت زیاد به کم', 'decs'),
    SortBy('price', 'قیمت کم به زیاد', 'asc'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: searchQury,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 12),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'جستجو',
                          hintStyle: const TextStyle(fontFamily: 'font1'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: const Color.fromARGB(255, 213, 213, 213),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffe6e6ec),
                        borderRadius: BorderRadius.circular(10)),
                    child: PopupMenuButton(
                      onSelected: (sortBy) {
                        CatalogProvider productList =
                            Provider.of<CatalogProvider>(context,
                                listen: false);
                        productList.initializeData();
                        productList.setSortOlder(sortBy);
                        productList.fatchProducts(page);
                      },
                      itemBuilder: (context) {
                        return sortByOption.map(
                          (item) {
                            return PopupMenuItem(
                              value: item,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  textDirection: TextDirection.rtl,
                                  item.text.toString(),
                                  style: const TextStyle(fontFamily: 'font1'),
                                ),
                              ),
                            );
                          },
                        ).toList();
                      },
                      icon: const Icon(Icons.tune),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<CatalogProvider>(
            builder: (context, productModel, child) {
              if (productModel.allProduct.isNotEmpty &&
                  productModel.getStatus() != DataStatus.initial) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: productModel.allProduct.map(
                        (e) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Constants.blue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Constants.white,
                                    blurRadius: 15,
                                    spreadRadius: 10),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Constants.blue,
                                        ),
                                        Image.network(
                                          e.images![0].src.toString(),
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      e.name.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'font2',
                                          fontSize: 14,
                                          color: Constants.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${numberFormat.format(int.parse(e.price ?? '000'))}تومان'
                                              .farsiNumber,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                              fontFamily: 'font1',
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}