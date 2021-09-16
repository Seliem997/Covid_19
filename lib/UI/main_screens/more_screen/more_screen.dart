import 'package:covid19/UI/main_screens/info_screen/info_screen.dart';
import 'package:covid19/UI/main_screens/map_screen/map_screen.dart';
import 'package:covid19/UI/user/edit_profile/edit_profileScreen.dart';
import 'package:covid19/colors.dart';
import 'package:covid19/providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MoreScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  static String routeName = "/MoreScreen";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 3.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              child: buildHelloUserTopPart(),
            ),
            SizedBox(height: 2.h),
            buildMoreItems(context),
          ],
        ),
      ),
    );
  }

  Column buildMoreItems(BuildContext context) {
    return Column(
      children: [
        buildMoreItem(context,
            text: "Profile",
            onTap: () =>
                Navigator.pushNamed(context, EditProfileScreen.routeName),
            iconData: FontAwesomeIcons.userAlt,
            color: MColors.covidMain),
        buildDivider(),
        buildMoreItem(context, onTap: () {
          Navigator.pushNamed(context, InfoScreen.routeName);
        },
            text: "Information",
            iconData: FontAwesomeIcons.info,
            color: MColors.covidMain),
        buildDivider(),
        buildMoreItem(context, onTap: () {
          Navigator.pushNamed(context, MapScreen.routeName);
        },
            text: "Map",
            iconData: FontAwesomeIcons.mapMarkedAlt,
            color: MColors.covidMain),
        buildDivider(),
        buildMoreItem(context,
            text: "Help",
            iconData: FontAwesomeIcons.questionCircle,
            color: MColors.covidMain),
        buildDivider(),
        buildMoreItem(context,
            text: "Share",
            iconData: FontAwesomeIcons.shareAlt,
            color: MColors.covidMain),
        buildDivider(),
        buildMoreItem(context, text: "Logout", onTap: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
            iconData: FontAwesomeIcons.signOutAlt,
            color: Colors.redAccent.withOpacity(.8)),
      ],
    );
  }

  Container buildDivider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        child: Divider(height: .1.h));
  }

  GestureDetector buildMoreItem(BuildContext context,
      {@required String text, IconData iconData, Color color, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        width: double.infinity,
        height: 5.h,
        child: Row(
          children: [
            Container(
                height: 5.h,
                width: 5.h,
                decoration: BoxDecoration(
                    // border: Border.all(),
                    color: MColors.covidMain.withOpacity(.1),
                    borderRadius: BorderRadius.circular(1.h)),
                child: Icon(
                  iconData,
                  color: color,
                )),
            SizedBox(width: 5.w),
            Text(
              text,
              style: TextStyle(
                  fontFamily: "Plex",
                  fontSize: 12.sp,
                  color: MColors.covidMain),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHelloUserTopPart() {
    return Container(
      height: 26.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        // color: MColors.covidMain,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Image Section
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: 15.h,
                  height: 15.h,
                  child: CircleAvatar(
                    radius: 5.h,
                    backgroundColor: MColors.covidMain,
                    backgroundImage: user.photoURL == null
                        ? AssetImage("assets/images/background.png")
                        : NetworkImage(user.photoURL),
                  ),
                ),
                Container(
                  width: 50.w,
                  margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: .2.h),
                  decoration: BoxDecoration(
                      color: MColors.covidMain.withOpacity(.1),
                      borderRadius: BorderRadius.circular(2.h)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        width: 50.w,
                        child: Text(
                          user.displayName == null ? "User" : user.displayName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: MColors.covidMain),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              color: MColors.covidThird,
            ),
          )
        ],
      ),
    );
  }

  Widget addTitleBar(String title) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        child: Text(
          title,
          // textScaleFactor: SizeConfig.textScaleFactor,
          style: TextStyle(
            fontSize: 16,
            color: MColors.covidMain,
          ),
        ),
      ),
    );
  }
}
