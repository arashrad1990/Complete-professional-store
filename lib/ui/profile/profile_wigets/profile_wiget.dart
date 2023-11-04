import 'package:flutter/material.dart';
import 'package:wordpress_app/constant/constant.dart';

class BuildProfileEmail extends StatelessWidget {
  final String? profileEmail;
  const BuildProfileEmail({
    super.key,
    this.profileEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$profileEmail',
      style: TextStyle(
        color: Constants.black.withOpacity(0.4),
        fontSize: 15.0,
      ),
    );
  }
}

class BuildProfileName extends StatelessWidget {
  final String? firstName;
  const BuildProfileName({
    super.key,
    this.firstName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$firstName',
          style: TextStyle(
            color: Constants.black,
            fontSize: 20.0,
            fontFamily: 'YekanBakh',
          ),
        ),
        const SizedBox(width: 5.0),
        SizedBox(
          height: 20.0,
          child: Image.asset(
            'assets/images/verified.png',
          ),
        ),
      ],
    );
  }
}

class BuildProfileOptions extends StatelessWidget {
  final Size size;
  const BuildProfileOptions({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: Column(
  
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BuildOptions(title: 'پروفایل من', icon: Icons.person),
          BuildOptions(
            title: 'سفارشات من',
            icon: Icons.settings,
            onPressed: () {
           
            },
          ),
          const BuildOptions(
              title: 'اطلاع رسانی‌ها', icon: Icons.notifications),
          const BuildOptions(
              title: 'شبکه‌های اجتماعی', icon: Icons.share_rounded),
          BuildOptions(
            title: 'خروج',
            icon: Icons.logout,
            onPressed: () {
            
            },
          ),
        ],
      ),
    );
  }
}



class BuildProfilePic extends StatelessWidget {
  final String? userAvatar;
  const BuildProfilePic({
    super.key,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Constants.blue.withOpacity(0.5),
          width: 5.0,
        ),
      ),
      child: CircleAvatar(
        radius: 60.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          '$userAvatar',
        ),
      ),
    );
  }
}

class BuildOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  const BuildOptions({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: Constants.black.withOpacity(0.4),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
       
                  style: TextStyle(
                    fontFamily: 'IranSans',
                    color: Constants.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5.0),
                Icon(
                  icon,
                  color: Constants.black.withOpacity(0.5),
                  size: 23.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 
}



class BuildProfileOption extends StatelessWidget {
  final Size size;
  const BuildProfileOption({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BuildOptions(title: 'پروفایل من', icon: Icons.person),
          BuildOptions(
            title: 'سفارشات من',
            icon: Icons.settings,
            onPressed: () {
              
            },
          ),
          const BuildOptions(
              title: 'اطلاع رسانی‌ها', icon: Icons.notifications),
          const BuildOptions(
              title: 'شبکه‌های اجتماعی', icon: Icons.share_rounded),
          BuildOptions(
            title: 'خروج',
            icon: Icons.logout,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
