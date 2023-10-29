import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/ui/cart/cartpage.dart';
import 'package:wordpress_app/ui/catalog/catalog.dart';
import 'package:wordpress_app/ui/home/homepage.dart';
import 'package:wordpress_app/ui/profile/profilepage.dart';
import 'package:wordpress_app/ui/singup/singup.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPagePageState();
}

class _RootPagePageState extends State<RootPage> {
  int bottomIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    CatalogPage(),
    CartPage(),
    ProfilePage()
  ];
// icons botton navigator
  List<IconData> iconlist = const [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];
  // text botton navigator
  List<String> appbartitlelist = const [
    'خانه',
    'علاقه مندی ها',
    'سبد خرید',
    'پروفایل',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //icon top notifications
            children: [
              const Icon(
                color: Colors.black54,
                Icons.notifications,
              ),
              Text(
                appbartitlelist[bottomIndex],
                style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: 'font2',
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Constants.blue.withOpacity(0.5),
        elevation: 0.0,
      ),
      // change icons navigator botton
      body: IndexedStack(
        index: bottomIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Constants.blue,
        //icocn home center
        child: Icon(
          Icons.home,
          size: 30,
          color: Constants.white.withOpacity(0.8),
        ),
        // push page in SingupPage
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SingupPage();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        notchMargin: 3,
        iconSize: 30,
        //LinearGradient AnimatedBottomNavigationBar
        backgroundGradient: LinearGradient(
          colors: [
            Constants.white,
            Constants.blue,
          ],
        ),
        splashColor: Constants.blue.withOpacity(0.5),
        activeColor: Constants.blue,
        activeIndex: bottomIndex,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        backgroundColor: Constants.blue.withOpacity(0.2),
        icons: iconlist,
        onTap: (index) {
          setState(() {
            bottomIndex = index;
          });
        },
      ),
    );
  }
}
