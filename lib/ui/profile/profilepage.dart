import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/constant/constant.dart';
import 'package:wordpress_app/models/woocamers/verify_model.dart';
import 'package:wordpress_app/provider/shop_provider.dart';
import 'package:wordpress_app/ui/profile/profile_wigets/profile_wiget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ShopProvider shopProvider =
      Provider.of<ShopProvider>(context, listen: false);
  late CustomerDetailsModel? userDetail =
      Provider.of<ShopProvider>(context, listen: false).customerDetailsModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBar(
          title: const Text('پروفایل'),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: shopProvider.fetchShipingDetaile(),
        builder: (BuildContext context, AsyncSnapshot shipingDetail) {
          if (shipingDetail.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Constants.blue,
                size: 50,
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(20.0),
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  // profile image
                  BuildProfilePic(userAvatar: userDetail?.avatarURL),
                  const SizedBox(height: 20.0),
                  // profile name
                  BuildProfileName(firstName: userDetail?.firstName),
                  // end profile name
                  const SizedBox(height: 10.0),
                  // profile email
                  BuildProfileEmail(profileEmail: userDetail?.email),
                  // end profile email
                  const SizedBox(height: 30.0),
                  // Profile Options
                  BuildProfileOptions(size: size),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
