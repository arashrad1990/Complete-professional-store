import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/verify_model.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/peyment/peyment_option.dart';

class VerifyAddress extends StatefulWidget {
  const VerifyAddress({super.key});

  @override
  State<VerifyAddress> createState() => _VerifyAddressState();
}

class _VerifyAddressState extends State<VerifyAddress> {
  final GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider productList =
          Provider.of<ShopProvider>(context, listen: false);

      productList.fetchShipingDetaile();
    });
    super.initState();
  }

  Widget _formUI(
    CustomerDetailsModel? model,
  ) {
    final TextEditingController firstname,
        lastname,
        address1,
        address2,
        country,
        mobile,
        city,
        postCode;
    firstname = TextEditingController(text: model!.firstName.toString());
    lastname = TextEditingController(text: model.lastName.toString());
    address1 = TextEditingController(text: model.shipping!.address1.toString());
    address2 = TextEditingController(text: model.shipping!.address2.toString());
    country = TextEditingController(text: model.shipping!.country.toString());
    mobile = TextEditingController(text: model.shipping!.phone.toString());
    city = TextEditingController(text: model.shipping!.city.toString());
    postCode = TextEditingController(text: model.shipping!.postCode.toString());

    return Form(
      key: globalKey2,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.only(top: 60.0),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'نام',
                        controller: firstname,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'نام خانوادگی',
                        controller: lastname,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                BuildCustomFormField(
                  labelName: 'خیابان اصلی',
                  controller: address1,
                  validator: CustomValidator.fieldMustComplete,
                ),
                const SizedBox(height: 30),
                BuildCustomFormField(
                  labelName: 'خیابان فرعی، کوچه و ....',
                  controller: address2,
                  validator: CustomValidator.fieldMustComplete,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'کشور',
                        controller: country,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'شهر',
                        controller: city,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'موبایل',
                        controller: mobile,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Flexible(
                      child: BuildCustomFormField(
                        labelName: 'کد پستی',
                        controller: postCode,
                        validator: CustomValidator.fieldMustComplete,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.blue.withOpacity(0.9),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'مرحله بعدی',
                        style: TextStyle(
                          fontFamily: 'Lalezar',
                          fontSize: 15.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PaymentOptions();
                            },
                          ),
                        );
                      },
                    ),
                    // inja
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          Provider.of<ShopProvider>(context, listen: false)
                              .updateCustomerDetile(
                            CustomerDetailsModel(
                              firstName: firstname.text,
                              lastName: lastname.text,
                              shipping: Shipping(
                                firstName: firstname.text,
                                lastName: lastname.text,
                                address1: address1.text,
                                address2: address2.text,
                                city: city.text,
                                country: country.text,
                                phone: mobile.text,
                                postCode: postCode.text,
                              ),
                              billing: Billing(
                                email: Provider.of<ShopProvider>(context,
                                        listen: false)
                                    .customerDetailsModel!
                                    .email,
                                firstName: firstname.text,
                                lastName: lastname.text,
                                address1: address1.text,
                                address2: address2.text,
                                city: city.text,
                                country: country.text,
                                phone: mobile.text,
                                postCode: postCode.text,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.sync))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  late ShopProvider userDetail =
      Provider.of<ShopProvider>(context, listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBar(title: const Text('تکمیل اطلاعات')),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: userDetail.fetchShipingDetaile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<ShopProvider>(
              builder: (context, cartModel, child) {
                return Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: cartModel.isLoadingShippingDetails ? 0.5 : 1,
                      child: AbsorbPointer(
                        absorbing: cartModel.isLoadingShippingDetails,
                        child: _formUI(cartModel.customerDetailsModel),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
