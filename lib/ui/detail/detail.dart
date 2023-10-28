import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/shop_provider.dart';

class DetailPage extends StatefulWidget {
  final int? data;

  const DetailPage({super.key, this.data});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool flag = true;
  // shop provider
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider webLogProvider =
          Provider.of<ShopProvider>(context, listen: false);
      webLogProvider.weblogPosts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (BuildContext context, ShopProvider value, Widget? child) {
        // rendered shop weblog
        late String description = removeAllHtmlTags(
            value.postweblog[widget.data!].content!.rendered.toString());
        late String firstHalf;
        late String secondHalf;

        if (description.length > 150) {
          firstHalf = description.substring(0, 150);
          secondHalf = description.substring(150, description.length);
        } else {
          firstHalf = description;
          secondHalf = "";
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                //LinearGradient background
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    gradient: LinearGradient(
                        colors: [Constants.white, Constants.blue]),
                    color: Constants.blue,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 60, right: 20),
                        child: Container(
                          width: 400,
                          height: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Constants.blue.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // title weblog
                                   Text(
                                    value.postweblog[widget.data!].title
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: 'font2', fontSize: 20),
                                  ),
                                  firstHalf.isEmpty
                                      ? const Text(
                                          "توضیحاتی وجود ندارد",
                                          style: TextStyle(
                                              fontFamily: 'font2',
                                              fontSize: 20),
                                        )
                                    : Directionality(
                                          textDirection: TextDirection.rtl,
                                          // content weblog
                                          child: Text(
                                            flag
                                                ? "$firstHalf...."
                                                : firstHalf + secondHalf,
                                            style: const TextStyle(
                                              fontFamily: 'font1',
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                  InkWell(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // show and hide content weblog
                                        Text(
                                          flag
                                              ? "ادامه توضیحات"
                                              : "بستن توضیحات",
                                          style: TextStyle(
                                            color: Constants.black
                                                .withOpacity(0.7),
                                            fontFamily: 'font2',
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        flag = !flag;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 150, left: 270),
                        // close page botton
                        child: ElevatedButton.icon(
                          onPressed: () {
                            return Navigator.pop(context);
                          },
                          icon: const Icon(Icons.backspace),
                          label: const Text("بازگشت"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
