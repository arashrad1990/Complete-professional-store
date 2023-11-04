import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/order_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      OrderProvider orderProvider =
          Provider.of<OrderProvider>(context, listen: false);
      orderProvider.fetchOrders();
    });
    super.initState();
  }

  Widget buildTextIcon(
    Icon iconWidget,
    Text textWidget,
  ) {
    return Row(
      children: [
        iconWidget,
        const SizedBox(width: 5.0),
        textWidget,
      ],
    );
  }

  Widget orderStatus(
    String status,
  ) {
    Icon icon;
    Color color;

    if (status == 'pending' || status == 'processing' || status == 'on-hold') {
      icon = const Icon(Icons.timer, color: Color.fromARGB(255, 222, 156, 57));
      color = const Color.fromARGB(255, 196, 121, 8);
    } else if (status == 'completed') {
      icon = const Icon(Icons.check, color: Color.fromARGB(255, 73, 164, 74));
      color = const Color.fromARGB(255, 70, 121, 71);
    } else if (status == 'cancelled' ||
        status == 'refunded' ||
        status == 'failed') {
      icon = const Icon(Icons.clear, color: Color.fromARGB(255, 163, 63, 63));
      color = const Color.fromARGB(255, 141, 26, 26);
    } else {
      icon = const Icon(Icons.clear, color: Color.fromARGB(255, 163, 63, 63));
      color = const Color.fromARGB(255, 141, 26, 26);
    }

    return buildTextIcon(
      icon,
      status == 'pending'
          ? Text(
              'سفارش در انتظار بررسی',
              style: TextStyle(
                color: color,
                fontFamily: 'YekanBakh',
                fontSize: 16,
              ),
            )
          : status == 'processing'
              ? Text(
                  'سفارش در حال انجام',
                  style: TextStyle(
                    color: color,
                    fontFamily: 'YekanBakh',
                    fontSize: 16,
                  ),
                )
              : status == 'on-hold'
                  ? Text(
                      'سفارش در انتظار پرداخت',
                      style: TextStyle(
                        color: color,
                        fontFamily: 'YekanBakh',
                        fontSize: 16,
                      ),
                    )
                  : status == 'completed'
                      ? Text(
                          'سفارش تکمیل شده',
                          style: TextStyle(
                            color: color,
                            fontFamily: 'YekanBakh',
                            fontSize: 16,
                          ),
                        )
                      : status == 'cancelled'
                          ? Text(
                              'سفارش لغو شده',
                              style: TextStyle(
                                color: color,
                                fontFamily: 'YekanBakh',
                              ),
                            )
                          : Text(
                              'کنسل',
                              style: TextStyle(
                                color: color,
                                fontFamily: 'YekanBakh',
                                fontSize: 16,
                              ),
                            ),
    );
  }

  String toStringFormatter(Jalali? d) {
    final f = d!.formatter;
    return '${d.minute} : ${d.hour}   - -   ${f.y}/${f.m}/${f.d}'.farsiNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  AppBar(title: const Text('سفارش‌ها')),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderModel, child) {
          if (orderModel.isLoading) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Constants.blue,
                size: 50,
              ),
            );
          }
          if (orderModel.allOrders != null &&
              orderModel.allOrders!.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: orderModel.allOrders!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
              
                          children: [
                            const SizedBox(height: 20.0),
                            orderStatus(
                                orderModel.allOrders![index].status.toString()),
                            const Divider(color: Colors.black),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    buildTextIcon(
                                      const Icon(Icons.info_outline_rounded),
                                      const Text(
                                        'شماره سفارش : ',
                                        style: TextStyle(
                                          fontFamily: 'YekanBakh',
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  orderModel.allOrders![index].orderId
                                      .toString()
                                      .farsiNumber,
                                  style: TextStyle(
                                    fontFamily: 'Lalezar',
                                    fontSize: 18.0,
                                    color: Constants.blue,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    buildTextIcon(
                                      const Icon(Icons.timelapse),
                                      const Text(
                                        'تاریـخ سفـارش : ',
                                        style: TextStyle(
                                          fontFamily: 'YekanBakh',
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  toStringFormatter(orderModel
                                          .allOrders![index].orderDate)
                                      .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Lalezar',
                                    fontSize: 18.0,
                                    color: Constants.blue,
                                  ),
                                ),
                              ],
                            ),
                        
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'هیچ سفارشی ثبت نشده',
                style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 18.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
