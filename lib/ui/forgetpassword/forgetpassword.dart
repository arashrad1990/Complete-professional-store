import 'package:flutter/material.dart';
import 'package:wordpress_app/constant/constant.dart';

class ForgetPasssword extends StatefulWidget {
  const ForgetPasssword({super.key});

  @override
  State<ForgetPasssword> createState() => _ForgetPassswordState();
}

class _ForgetPassswordState extends State<ForgetPasssword> {
  @override
  Widget build(BuildContext context) {
    // email in forget password
    TextEditingController email = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          //LinearGradient backgroung
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
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                // email text
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      controller: email,
                      style: const TextStyle(fontFamily: 'font2', fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "ایمیل",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // restore forget password
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.restore),
                        label: const Text(
                          "بازنشانی پسورد شما",
                          style: TextStyle(fontFamily: 'font2', fontSize: 20),
                        ),
                      ),

                      // close botton
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        label: const Text(
                          "بازگشت",
                          style: TextStyle(fontFamily: 'font2', fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
