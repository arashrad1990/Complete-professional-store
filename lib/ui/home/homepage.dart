import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/detail/detail.dart';
import 'package:wordpress_app/ui/detailpageshop/detailshop.dart';
import 'package:intl/intl.dart' show NumberFormat;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFavorite = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      ShopProvider shopProvider =
          Provider.of<ShopProvider>(context, listen: false);
      shopProvider.allGategorByid("17");
      shopProvider.allGategori();
      shopProvider.weblogPosts();
      // shopProvider.allProduct();
    });
    super.initState();
  }

  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    NumberFormat numberformat = NumberFormat.decimalPattern('fa');
    Size size = MediaQuery.of(context).size;
    return Consumer<ShopProvider>(
      builder: (context, value, child) {
        return Scaffold(
          //search tabbar program
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        // search botton and icon mic
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const Expanded(
                                // text search
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    showCursor: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      hintText: "جستجو...",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'font2',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              // icon search
                              Icon(
                                Icons.search,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //catecory product
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 80,
                      width: size.width,
                      child: ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.productGategori.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15, right: 8),
                            child: GestureDetector(
                              onTap: () {
                                // productGategori id for productGategoriny id
                                final catId =
                                    value.productGategori[index].id.toString();
                                setState(() {
                                  selectIndex = index;
                                  value.allGategorByid(catId.toString());
                                });
                              },
                              //  productGategori name--
                              child: Text(
                                " | ${value.productGategori[index].name} | ",
                                style: TextStyle(
                                  fontFamily: 'font2',
                                  fontSize: 18,
                                  fontWeight: selectIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.w300,
                                  color: selectIndex == index
                                      ? Colors.black87
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //product one
                    SizedBox(
                      height: size.width * 0.5,
                      child: value.isLoding
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: value.productGategoribyid.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailShop(
                                          data:
                                              value.productGategoribyid[index],
                                        );
                                      }),
                                    );
                                  },
                                  child: Container(
                                    width: 200,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Constants.blue.withOpacity(1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          right: 10,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isFavorite = !isFavorite;
                                              });
                                              value.productGategoribyid[index]
                                                  .isFavorit = isFavorite;
                                            },
                                            //favorite_outline_outlined icon
                                            icon: Icon(
                                              value.productGategoribyid[index]
                                                      .isFavorit!
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                              color: Constants.red
                                                  .withOpacity(0.8),
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, top: 70),
                                          child: SizedBox(
                                            width: 100,
                                            height: 85,
                                            child: Image.network(
                                              value.productGategoribyid[index]
                                                  .images![0].src
                                                  .toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),

                                        // price product
                                        Positioned(
                                          left: 15,
                                          bottom: 15,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Constants.white,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            child: Text(
                                              '${numberformat.format(int.parse(value.productGategoribyid[index].price.toString()))}تومان'
                                                  .farsiNumber,
                                              style: const TextStyle(
                                                fontFamily: 'font1',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //categories name product
                                        Positioned(
                                          top: 15,
                                          left: 20,
                                          child: Column(
                                            children: [
                                              Text(
                                                value.productGategoribyid[index]
                                                    .categories![0].name
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'font2',
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                value.productGategoribyid[index]
                                                    .name
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'font1',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
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
                            ),
                    ),
                    //text part
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          const EdgeInsets.only(right: 18, bottom: 15, top: 20),
                      child: const Text(
                        "محصولات",
                        style: TextStyle(
                          fontFamily: 'font1',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //postweblog bulider
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      height: size.height * 0.3,
                      child: value.islodingWeblog
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.postweblog.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Constants.blue.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 100,
                                    width: size.width,
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //data for page detail
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                  data: index,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "کلیک کنید",
                                            style: TextStyle(
                                              fontFamily: 'font2',
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              child: SizedBox(
                                                height: 80,
                                                child: Icon(
                                                  Icons.article,
                                                  size: 60,
                                                  color: Constants.white,
                                                ),
                                              ),
                                            ),
                                            // id weblog
                                            Positioned(
                                              bottom: 5,
                                              right: 70,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    value.postweblog[index].id
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'font1',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  // title weblog
                                                  Text(
                                                    value
                                                        .postweblog[index].title
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontFamily: 'font2',
                                                      fontSize: 18,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
