import 'package:flutter/material.dart';
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/registermodel.dart';
import 'package:wordpress_app/ui/singin/singin.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  late ApiService apiService;
  late CustomerModel customerModel;
  bool isApiCall = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    apiService = ApiService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //LinearGradient background
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  gradient:
                      LinearGradient(colors: [Constants.white, Constants.blue]),
                  color: Constants.blue,
                ),
              ),
              //columnText name
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: columnText(
                        const EdgeInsets.only(top: 20, right: 15, left: 15),
                        TextDirection.rtl,
                        TextDirection.rtl,
                        'نام',
                        customerModel.fristnName,
                        (value) {
                          customerModel.fristnName = value;
                        },
                        'نام',
                        RegExp(''),
                      ),
                    ),
                    //columnText family
                    columnText(
                      const EdgeInsets.only(top: 20, right: 15, left: 15),
                      TextDirection.rtl,
                      TextDirection.rtl,
                      ' نام خانوادگی',
                      customerModel.lastName,
                      (value) {
                        customerModel.lastName = value;
                      },
                      'نام خانوادگی',
                      RegExp(''),
                    ),
                    //columnText email
                    columnText(
                      const EdgeInsets.only(top: 20, right: 15, left: 15),
                      TextDirection.rtl,
                      TextDirection.ltr,
                      'امیل',
                      customerModel.email,
                      (value) {
                        customerModel.email = value;
                      },
                      'امیل',
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
                    ),
                    //columnText pasword
                    columnText(
                      const EdgeInsets.only(top: 20, right: 15, left: 15),
                      TextDirection.rtl,
                      TextDirection.ltr,
                      'پسورد',
                      customerModel.pasword,
                      (value) {
                        customerModel.pasword = value;
                      },
                      'پسورد',
                      RegExp(
                        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //botton valid api
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 15),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  isApiCall = true;
                                });
                                apiService.creactEmail(customerModel).then(
                                  (retres) {
                                    if (retres) {
                                      setState(() {
                                        isApiCall = false;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return showdialogtext("شد", context);
                                        },
                                      );
                                    } else {
                                      showdialogtext('نشد', context);
                                    }
                                  },
                                );
                              }
                            },
                            icon: const Icon(Icons.app_registration),
                            label: const Text("ثبت نام"),
                          ),
                        ),
                        Padding(
                          //botton push Singin
                          padding: const EdgeInsets.only(top: 15, right: 40),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Singin();
                                  },
                                ),
                              );
                            },
                            icon: const Icon(Icons.account_balance),
                            label: const Text("قبلا اکانت داششتید"),
                          ),
                        )
                      ],
                    ),
                    isApiCall
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "لطفا منتظر بمانید...",
                                  style: TextStyle(
                                      fontFamily: 'font2', fontSize: 20),
                                ),
                                CircularProgressIndicator(),
                              ],
                            ),
                          )
                        : const Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
