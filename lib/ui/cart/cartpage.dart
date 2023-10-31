import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider cartItemList =
          Provider.of<ShopProvider>(context, listen: false);
      cartItemList.initdata();
      cartItemList.fatchCartItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NumberFormat numberformat = NumberFormat.decimalPattern('fa');
    return Consumer<ShopProvider>(
      builder: (BuildContext context, value, child) {
        if (value.isLoding) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (value.itemsinCart!.isNotEmpty) {
          return Scaffold(
            body: Column(
              children: [
                Flexible(
                  flex: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.itemsinCart!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Constants.blue.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 80,
                          width: size.width,
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                      height: 20,
                                      child: Icon(Icons.attach_money_outlined)),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    numberformat.format(int.parse(
                                      value.itemsinCart![index]
                                          .productRegularPrice
                                          .toString(),
                                    )),
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      fontSize: 20,
                                      color: Constants.teal,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 5),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Constants.blue.withOpacity(0.4),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            value.itemsinCart![index].thumbnail
                                                .toString(),
                                            scale: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 70,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              value.itemsinCart![index]
                                                  .productName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'font1',
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        CustomMinMaxPrice(
                                          numberMin: 0,
                                          numberMax: 20,
                                          iconSize: 15,
                                          value: 1,
                                          onChanged: (value) {},
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Divider(
                                  thickness: 0.5,
                                ),
                                const Text(
                                  "جمع کل",
                                  style: TextStyle(
                                    fontFamily: 'font1',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                          height: 15,
                                          child: Icon(
                                            Icons.shopping_basket_rounded,
                                            color: Constants.teal,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "50000".farsiNumber,
                                        style: TextStyle(
                                          fontFamily: 'font2',
                                          color: Constants.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.sync),
                            ),
                            InkResponse(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Constants.blue.withOpacity(0.50),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: InkResponse(
                                  onTap: () {},
                                  child: Text(
                                    "مرحله بعد",
                                    style: TextStyle(
                                        fontFamily: 'font1',
                                        fontSize: 20,
                                        color: Constants.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
