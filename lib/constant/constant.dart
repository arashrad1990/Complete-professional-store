import 'package:flutter/material.dart';
import 'package:wordpress_app/user_pass/password.dart';

class WoocommerceInfo {
  // BASE URL
  static const String _baseURL = 'https://stokecom.ir/wp-json';

  // CONSUMERKEY & CONSUMERSECRET
  static String consumerKey = PassProgram().consumerKey.toString();
  static String consumerSecret = PassProgram().consumerSecret.toString();

  // BASE URL WOOCOMMERCE
  static const String baseURL = '$_baseURL/wc/v3/';

  // Base URL of Wordpress
  static const String baseURLPosts = '$_baseURL/wp/v2/posts?_embed';

  // URL FOR AUTHENTICATION WITH JWT
  static const String tokenURL = '$_baseURL/jwt-auth/v1/token';

  // API ENDPOINTS
  static const String customerURL = 'customers';
  static const String productURL = 'products';
  static const String addtocartURL = 'addtocart';
  static const String cartURL = 'cart';
  static const String productCategoryURL = 'products/categories/products';
  static const String orderURL = 'orders';
}

class ZarinPall {
  final String callbackurl = "https://stokecom.com";
  final String merchantid = Zarinpallmerchend().merchantid;
  final String zarinPallRequest =
      "https://api.zarinpal.com/pg/v4/payment/request.json";

  final String zarinPallverify =
      "https://api.zarinpal.com/pg/v4/payment/verify.json";
}

class Constants {
  static Color black = Colors.black;
  static Color green = const Color(0xFF296E48);
  static Color white = Colors.white;
  static Color blue = Colors.blue;
  static Color teal = Colors.teal;
  static Color red = Colors.red;
}

Widget columnText(
  EdgeInsetsGeometry padding,
  TextDirection textDirection,
  TextDirection? textDirectiontwoo,
  String hintText,
  Object? initialValue,
  Function(String)? onChanged,
  String nameerror,
  RegExp regExp,
) {
  return Padding(
    padding: padding,
    child: Directionality(
      textDirection: textDirection,
      child: TextFormField(
        textDirection: textDirectiontwoo,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        initialValue: initialValue != null ? initialValue.toString() : "",
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return "$nameerror شما خالی است";
          } else if (value.length < 3) {
            return "$nameerror شما کمتر از 3 حروف است";
          } else if (!regExp.hasMatch(value)) {
            return "$nameerror شما نا معتبر است";
          } else {
            return null;
          }
        },
        style: const TextStyle(fontFamily: 'font2', fontSize: 20),
      ),
    ),
  );
}

Widget showdialogtext(String error, BuildContext context) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: AlertDialog(
      title: const Text(
        "ساخت اکانت",
        style: TextStyle(
          fontFamily: 'font2',
          fontSize: 15,
        ),
      ),
      content: Text(
        "اکانت شما با موفقیعت ساخته" " $error",
        style: const TextStyle(
          fontFamily: 'font1',
          fontSize: 20,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "بستن",
            style: TextStyle(
              fontFamily: 'font2',
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

extension FarsiNumberEXtension on String {
  String get farsiNumber {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲	', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String text = this;
    for (int i = 0; i < english.length; i++) {
      text = text.replaceAll(english[i], farsi[i]);
    }
    return text;
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

// ignore: must_be_immutable
class CustomMinMaxPrice extends StatefulWidget {
  final int numberMin;
  final int numberMax;
  final double iconSize;
  int value;
  final ValueChanged onChanged;

  CustomMinMaxPrice({
    super.key,
    required this.numberMin,
    required this.numberMax,
    required this.iconSize,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomMinMaxPrice> createState() => _CustomMinMaxPriceState();
}

class _CustomMinMaxPriceState extends State<CustomMinMaxPrice> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          // iconSize: widget.iconSize,
          onPressed: () {
            setState(() {
              widget.value = widget.value == widget.numberMin
                  ? widget.numberMin
                  : widget.value -= 1;
              widget.onChanged(widget.value);
            });
          },
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 10,
          child: Text(
            '${widget.value}'.farsiNumber,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'font1',
              fontSize: 15,
            ),
          ),
        ),
        IconButton(
          // iconSize: widget.iconSize,
          onPressed: () {
            setState(() {
              widget.value = widget.value == widget.numberMax
                  ? widget.numberMax
                  : widget.value += 1;
              widget.onChanged(widget.value);
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class BuildCustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextDirection formFieldtextDirection;
  final String labelName;

  const BuildCustomFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.formFieldtextDirection = TextDirection.rtl,
    required this.labelName,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        obscureText: obscureText,
        onChanged: onChanged,
        controller: controller,
        cursorColor: Constants.blue.withOpacity(0.5),
        style: const TextStyle(
          fontFamily: 'font1',
          fontSize: 20.0,
          height: 2.0,
        ),
        textDirection: formFieldtextDirection,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontFamily: 'font1',
          ),
          hintTextDirection: TextDirection.rtl,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.blue.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          label: Text(
            labelName,
            style: TextStyle(
              fontFamily: 'font2',
              fontSize: 20.0,
              color: Constants.blue.withOpacity(0.5),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}

class CustomValidator {
  static String? fieldMustComplete(String? value) {
    if (value.toString().isEmpty) {
      return 'این فیلد باید تکمیل شود';
    }
    return null;
  }
}

class BuildClickPaymentMethod extends StatelessWidget {
  final String assetImageUrl;
  final String paymentTitle;
  final String paymentDescription;
  final VoidCallback onPressed;

  const BuildClickPaymentMethod({
    required this.assetImageUrl,
    required this.paymentTitle,
    required this.paymentDescription,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Constants.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          // NABEGHEHA.COM
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 45.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                image: DecorationImage(
                  image: AssetImage(assetImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentTitle,
                          style: const TextStyle(
                            fontFamily: 'font2',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          paymentDescription,
                          style: const TextStyle(
                            fontFamily: 'font21',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
