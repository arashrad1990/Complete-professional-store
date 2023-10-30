import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/addtocart_requests_model.dart';
import 'package:wordpress_app/models/woocamers/product_model.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:wordpress_app/provider/loding_provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class DetailShop extends StatefulWidget {
  final ProductModel? data;
  const DetailShop({super.key, this.data});

  @override
  State<DetailShop> createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('fa');
  // description index
  late String description =
      removeAllHtmlTags(widget.data!.shortdescription.toString());
  late String firstHalf;
  late String secondHalf;
  bool flag = true;
  int quantity = 1;
  CartProduct cartProduct = CartProduct();
  @override
  void initState() {
    super.initState();
// check descripton length
    if (description.length > 150) {
      firstHalf = description.substring(0, 150);
      secondHalf = description.substring(150, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LodingProvider>(
      builder: (context, loader, child) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Constants.green.withOpacity(0.18),
                        ),
                        // close Icon
                        child: Icon(
                          Icons.close,
                          color: Constants.blue.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 50),
                //container show name product and price and image
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.9,
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 5),

                                  // name product
                                  child: Text(
                                    widget.data!.name.toString(),
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  // categories product
                                  child: Text(
                                    widget.data!.categories
                                        .toString()
                                        .replaceFirst("]", " ")
                                        .replaceAll("[", " "),
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 35),
                                  //regularprice name product
                                  child: Text(
                                    "قیمت",
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 35),
                                  //regularprice  product
                                  child: Text(
                                    '${numberFormat.format(int.parse(widget.data!.regularprice.toString()))}تومان'
                                        .farsiNumber,
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 40),
                                  //price name product
                                  child: Text(
                                    "قیمت بعد از تخفیف",
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 35),
                                  //price  product
                                  child: Text(
                                    '${numberFormat.format(int.parse(widget.data!.price.toString()))}تومان'
                                        .farsiNumber,
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      color: Constants.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          width: 110,
                          height: 200,
                          // image product
                          child: widget.data!.images![0].src!.isEmpty
                              ? const CircularProgressIndicator()
                              : Image.network(
                                  widget.data!.images![0].src.toString(),
                                  width: 300,
                                  height: 400,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, top: 420),
                    //cirle conatanier
                    child: Container(
                      decoration: BoxDecoration(
                        color: Constants.green.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60),
                        ),
                      ),
                      width: size.width,
                      height: size.height * 0.9,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 50, right: 20, left: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                // name product down
                                child: Text(
                                  widget.data!.name.toString(),
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontFamily: 'font2',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.green,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 80, right: 10),
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      // image product down
                                      child: widget
                                              .data!.images![0].src!.isEmpty
                                          ? const CircularProgressIndicator()
                                          : Image.network(
                                              widget.data!.images![0].src
                                                  .toString(),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 5, right: 10),
                                    // price product down
                                    child: Text(
                                      '${numberFormat.format(int.parse(widget.data!.price.toString()))}تومان'
                                          .farsiNumber,
                                      style: TextStyle(
                                        fontFamily: 'font2',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              // show and hide deccription
                              firstHalf.isEmpty
                                  ? const Text(
                                      "توضیحاتی وجود ندارد",
                                      style: TextStyle(
                                          fontFamily: 'font2', fontSize: 20),
                                    )
                                  : Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        flag
                                            ? "$firstHalf...."
                                            : firstHalf + secondHalf,
                                        style: const TextStyle(
                                          fontFamily: 'font1',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                              // ontap show and hide deccription
                              InkWell(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      flag ? "ادامه توضیحات" : "بستن توضیحات",
                                      style: TextStyle(
                                        color: Constants.blue,
                                        fontFamily: 'font2',
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    flag = !flag;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // icon by cart
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Constants.green.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 5),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Constants.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 30),
                        child: Provider.of<ShopProvider>(context, listen: false)
                                    .itemsinCart ==
                                null
                            ? Text(
                                "0".farsiNumber,
                                style: const TextStyle(
                                  fontFamily: 'font2',
                                  fontSize: 25,
                                ),
                              )
                            : Container(
                                width: 15,
                                height: 28,
                                color: Constants.red,
                                child: Text(
                                  Provider.of<ShopProvider>(context,
                                          listen: true)
                                      .itemsinCart!
                                      .length
                                      .toString()
                                      .farsiNumber,
                                  style: TextStyle(
                                    fontFamily: 'font2',
                                    fontSize: 25,
                                    color: Constants.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // botton by cart

              Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Constants.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkResponse(
                    onTap: () {
                      cartProduct.quantity = quantity;
                      Provider.of<LodingProvider>(context, listen: false)
                          .setloadingStatus(true);
                      ShopProvider cartProvider =
                          Provider.of<ShopProvider>(context, listen: false);
                      cartProduct.productId = widget.data!.id;
                      cartProvider.addtoCart(cartProduct, (val) {
                        Provider.of<LodingProvider>(context, listen: false)
                            .setloadingStatus(false);
                      });
                    },
                    child: loader.isApiCalled
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'افزودن به سبد خرید',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'font2',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
