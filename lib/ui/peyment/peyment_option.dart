import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart';
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/zarinpallmodel.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/peyment_web_bank/peyment_web_bank.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  NumberFormat numberFormat = NumberFormat.decimalPattern();
  ZarinpallModel? zarinpallModel;
  ApiService? apiService;
  @override
  void initState() {
    zarinpallModel = ZarinpallModel();
    apiService = ApiService();
    super.initState();
  }

  zarinpallClick() async {
    await getAuthorityZarinpallCode(
            context.read<ShopProvider>().totalAmount!.toInt().toString())
        .then((value) {
      zarinpallModel = value;
    });

    String? authorityCode = zarinpallModel!.data!.authority;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PeymentWebZarinpall(authorityCode: authorityCode),
      ),
    );
  }

  Future<ZarinpallModel?> getAuthorityZarinpallCode(String totalAmount) async {
    zarinpallModel = await apiService!.getAuthority(totalAmount);
    return zarinpallModel;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (BuildContext context, cartmodel, child) {
        if (cartmodel.customerDetailsModel!.id != null) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: AppBar(
                  title: const Text(
                'روش پرداخت',
                style: TextStyle(fontFamily: 'font1', fontSize: 24),
              )),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 80,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Constants.blue.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          numberFormat
                              .format(cartmodel.totalAmount)
                              .farsiNumber,
                          style: TextStyle(
                            fontFamily: 'font2',
                            color: Constants.teal,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      textDirection: TextDirection.rtl,
                      'مبلغ نهایی',
                      style: TextStyle(
                        fontFamily: 'font2',
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: _formUI(),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 200,
            ),
          );
        }
      },
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              // ONLINE PAYMENTS
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/peyment.png',
                onPressed: () {},
                paymentTitle: 'پرداخت آنلاین',
                paymentDescription: 'از روش‌های زیر یکی را انتخاب کنید',
              ),
              // PAYMENTS METHODS
              const SizedBox(height: 10.0),
              // ZARINPAL
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/zarin.jpg',
                onPressed: zarinpallClick,
                paymentTitle: 'زرین پال',
                paymentDescription: 'پرداخت آنلاین با درگــاه زرین پال',
              ),
              const SizedBox(height: 10.0),
              // NEXTPAY
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/nexpay.png',
                onPressed: () {},
                paymentTitle: 'نکست پی',
                paymentDescription: 'پرداخت آنلاین با درگاه نکست پی',
              ),
              const SizedBox(height: 10.0),
              // OFFLINE PAYMENTS
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/online.png',
                onPressed: () {},
                paymentTitle: 'پرداخت آفلاین',
                paymentDescription: 'از روش‌های زیر یکی را انتخاب کنید',
              ),
              const SizedBox(height: 10.0),
              // CASH ON DELEVERY
              BuildClickPaymentMethod(
                assetImageUrl: 'assets/images/cod.jpg',
                onPressed: () {},
                paymentTitle: 'پرداخت در محل',
                paymentDescription: 'پرداخت درب منزل با دستگاه کارت خوان',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
