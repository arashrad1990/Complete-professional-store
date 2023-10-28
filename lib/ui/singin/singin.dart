import 'package:flutter/material.dart';
import 'package:wordpress_app/api/apiservice.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/login_model.dart';
import 'package:wordpress_app/ui/forgetpassword/forgetpassword.dart';

class Singin extends StatefulWidget {
  const Singin({super.key});

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {
  // text  and password
  TextEditingController email =
      TextEditingController(text: "kingarashrad1990@gmail.com");
  TextEditingController password = TextEditingController(text: "a19901990");
  late ApiService apiService;
  late LoginModel loginModel;
  bool isApiCall = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    apiService = ApiService();
    loginModel = LoginModel();
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
              Padding(
                padding: const EdgeInsets.only(top: 60, right: 15, left: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        //textfield email
                        child: TextFormField(
                          textDirection: TextDirection.ltr,
                          controller: email,
                          style: const TextStyle(
                              fontFamily: 'font2', fontSize: 16),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "ایمیل",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          //validator email
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " امیل شما خالی است";
                            } else if (value.length < 5) {
                              return "ایمیل شما کمتر از 5 حروف است";
                            } else if (RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return "ایمیل شما نا معتبر است";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    //text field password
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textDirection: TextDirection.ltr,
                          controller: password,
                          style: const TextStyle(
                              fontFamily: 'font2', fontSize: 16),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "پسورد",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          //validator password
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "پسورد شما خالی است";
                            } else if (value.length < 6) {
                              return "پسورد شما کمتر از 6 حروف است";
                            } else if (RegExp(
                                    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
                                .hasMatch(value)) {
                              return "پسورد شما نا معتبر است";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //vali icon in api
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  isApiCall = true;
                                });
                                apiService
                                    .customerLogin(email.text, password.text)
                                    .then(
                                  (retres) {
                                    debugPrint(retres.success.toString());
                                    if (retres.success!) {
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
                            icon: const Icon(Icons.login),
                            label: const Text(
                              "ورود",
                              style:
                                  TextStyle(fontFamily: 'font2', fontSize: 16),
                            ),
                          ),
                          //botton push ForgetPasssword
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const ForgetPasssword();
                                  },
                                ),
                              );
                            },
                            icon: const Icon(Icons.password),
                            label: const Text(
                              "رمز را فراموش کرده ام",
                              style:
                                  TextStyle(fontFamily: 'font2', fontSize: 16),
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
      ),
    );
  }
}
