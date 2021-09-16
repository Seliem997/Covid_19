import 'package:covid19/UI/main_screens/chat_screen/chat_screen.dart';
import 'package:covid19/UI/main_screens/covid_check/covid_check_screen.dart';
import 'package:covid19/UI/main_screens/home/home.dart';
import 'package:covid19/UI/main_screens/main_screen/main_screen_provider.dart';
import 'package:covid19/UI/main_screens/more_screen/more_screen.dart';
import 'package:covid19/UI/user/edit_profile/edit_profileScreen.dart';
import 'package:covid19/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainScreenProvider>(
      create: (_) => MainScreenProvider(),
      builder: (context, child) => Scaffold(
        body: Builder(builder: (context) {
          final provider =
              Provider.of<MainScreenProvider>(context, listen: false);
          switch (provider.currentIndex) {
            case 0:
              return HomeScreen();
            case 1:
              return ChatScreen();
            case 2:
              return MoreScreen();
            default:
              return null;
          }
        }),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  Positioned buildVirusIcon() {
    return Positioned(
        top: 12.h,
        left: -10.w,
        child: Opacity(
          opacity: .8,
          child: Image(
              image: AssetImage("assets/images/virus.png"),
              height: 20.h,
              width: 20.h),
        ));
  }

  Positioned buildTotalCases() {
    return Positioned(
      top: 10.h,
      right: 20.w,
      child: Container(
        height: 10.h,
        width: 30.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("6738",
                style: TextStyle(
                    fontFamily: "Plex",
                    fontWeight: FontWeight.bold,
                    color: MColors.covidThird,
                    fontSize: 30.sp)),
            Text("Total Cases",
                style: TextStyle(
                    fontFamily: "Plex",
                    // fontWeight: FontWeight.bold,
                    color: MColors.covidThird,
                    fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }

  Row buildHomeIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        HomeItem(
            icon: Icon(FontAwesomeIcons.mapMarkedAlt,
                color: MColors.covidMain, size: 4.h),
            text: "Map"),
        Spacer(),
        HomeItem(
            icon: Icon(FontAwesomeIcons.info,
                color: MColors.covidMain, size: 4.h),
            text: "Information"),
        Spacer(),
        HomeItem(
            icon: Icon(FontAwesomeIcons.mapMarkedAlt,
                color: MColors.covidMain, size: 4.h),
            text: "Map"),
        Spacer()
      ],
    );
  }

  Widget buildCovidCheckContainer() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, CovidCheckScreen.routeName),
      child: Container(
        height: 18.h,
        width: 90.w,
        padding: EdgeInsets.only(left: 2.w, right: 2.h, top: 2.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                // color: Colors.amber,
                color: Colors.grey[200],
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 5))
          ],
          color: Color(0xFFF3F4F5),
          borderRadius: BorderRadius.circular(3.h),

          // border: Border.all()
        ),
        child: Row(
          children: [
            Image(image: AssetImage("assets/images/doctor.png")),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Covid Check",
                    style: TextStyle(
                        fontFamily: "Plex",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                Text("Based on common\nsyndrome",
                    style: TextStyle(fontFamily: "Plex", fontSize: 10.sp)),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: MColors.kTextColor, size: 2.h),
            Spacer(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    final provider = Provider.of<MainScreenProvider>(context, listen: true);

    final user = FirebaseAuth.instance.currentUser;
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: provider.currentIndex,
      onTap: (value) {
        setState(() {
          provider.currentIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.facebookMessenger),
          label: "Chat",
        ),
        BottomNavigationBarItem(
            icon: user.photoURL == null
                ? Icon(FontAwesomeIcons.userAlt)
                : SizedBox(
                    height: 4.h,
                    width: 4.h,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: .5.w,
                              color: provider.currentIndex == 2
                                  ? MColors.covidMain
                                  : Colors.grey)),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL)),
                    ),
                  ),
            label: "Profile"),
      ],
      selectedItemColor: MColors.covidMain,
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);
  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10.h,
          width: 10.h,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  // color: Colors.amber,
                  color: Colors.grey[200],
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 5))
            ],
            color: Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(3.h),

            // border: Border.all()
          ),
          child: icon,
        ),
        SizedBox(height: 1.5.h),
        Text(text, style: TextStyle(fontFamily: "Plex"))
      ],
    );
  }
}
