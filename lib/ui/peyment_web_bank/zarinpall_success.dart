import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/loding_provider.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/root/root_page.dart';

class ZarinpallSuccess extends StatefulWidget {
  final int? refID;
  const ZarinpallSuccess({super.key, this.refID});

  @override
  State<ZarinpallSuccess> createState() => _ZarinpallSuccessState();
}

class _ZarinpallSuccessState extends State<ZarinpallSuccess> {
  @override
  void initState() {
    ShopProvider shopProvider =
        Provider.of<ShopProvider>(context, listen: false);
    shopProvider.createOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.blue.withOpacity(0.5),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Constants.black.withOpacity(0.5),
                  ),
                ),
              ),
              Text(
                "نتیجه تراکنش",
                style: TextStyle(
                  color: Constants.black.withOpacity(0.5),
                  fontFamily: 'font2',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        body: Consumer<ShopProvider>(
            builder: (BuildContext context, value, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/sefaresh.png",
                  height: 300,
                  width: 300,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "سفارش ثبت شما با موفقعیت انجام شد",
                  style: TextStyle(
                    fontFamily: 'font2',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "شماره تراکنش شما${widget.refID}",
                  style: const TextStyle(fontFamily: 'font1', fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Constants.green),
                      foregroundColor:
                          MaterialStatePropertyAll(Constants.white),
                    ),
                    onPressed: () {
                      value.resetCart((val) {
                        Provider.of<LodingProvider>(context, listen: false)
                            .setloadingStatus(true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RootPage(),
                          ),
                        );
                        Provider.of<LodingProvider>(context, listen: false)
                            .setloadingStatus(false);
                      });
                    },
                    child: const Text(
                      "بازشکت به صفحه اصلی",
                      style: TextStyle(fontFamily: 'font2', fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
