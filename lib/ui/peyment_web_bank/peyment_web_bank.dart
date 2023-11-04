import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/order_model.dart';
import 'package:wordpress_app/models/zarinpall_verfy.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/peyment_web_bank/zarinpall_success.dart';

class PeymentWebZarinpall extends StatefulWidget {
  final String? authorityCode;
  const PeymentWebZarinpall({
    super.key,
    this.authorityCode,
  });

  @override
  State<PeymentWebZarinpall> createState() => _PeymentWebZarinpallState();
}

class _PeymentWebZarinpallState extends State<PeymentWebZarinpall> {
  late InAppWebViewController controller;
  String url = "";
  double progress = 0;
  ApiService? apiService;
  ZarinpalVerify? zarinpalVerify;

  @override
  void initState() {
    apiService = ApiService();
    zarinpalVerify = ZarinpalVerify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              "درگاه بانکی زرین پال",
              style: TextStyle(
                color: Constants.black.withOpacity(0.5),
                fontFamily: 'font2',
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            "https://www.zarinpal.com/pg/StartPay/${widget.authorityCode}",
          ),
        ),
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(textZoom: 10),
        ),
        onLoadStart: (InAppWebViewController controller, Uri? url) async {
          String urlToString = url.toString();
          int? totalAmount = context.read<ShopProvider>().totalAmount!.toInt();
          if (urlToString.contains(ZarinPall().callbackurl)) {
            final Uri url = Uri.parse(urlToString);
            final String? authority = url.queryParameters['Authority'];
            final String? status = url.queryParameters['Status'];
            debugPrint(status);
            debugPrint(authority.toString());
            await apiService?.verfyPeyment(totalAmount, authority!).then(
              (value) {
                zarinpalVerify = value;
              },
            );
            if (!mounted) return;
            ShopProvider orderProvider =
                Provider.of<ShopProvider>(context, listen: false);
            OrderModel orderModel = OrderModel();
            orderModel.paymentMethod = 'آنلاین';
            orderModel.paymentMethodTitle = 'پرداخت از طریق درگاه زرین پال';
            orderModel.setPaid = true;
            orderModel.transactionId =
                'کد رهگیری پرداخت زرین پال : ${(zarinpalVerify?.data?.refId).toString()}';
            orderProvider.processOrder(orderModel);
            Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute(
                  builder: (context) => ZarinpallSuccess(
                    refID: zarinpalVerify?.data?.refId,
                  ),
                ),
                (route) => false);
          }
        },
      ),
    );
  }
}
