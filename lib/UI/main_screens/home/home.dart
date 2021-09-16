import 'package:covid19/UI/main_screens/covid_check/covid_check_screen.dart';
import 'package:covid19/UI/main_screens/home/home_presenter.dart';
import 'package:covid19/UI/main_screens/home/model/CovidCasesResponse.dart';
import 'package:covid19/UI/main_screens/info_screen/info_screen.dart';
import 'package:covid19/UI/main_screens/map_screen/map_screen.dart';
import 'package:covid19/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePagePresenter presenter = HomePagePresenter();
  String cases;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => presenter.getCovidCases(),
      displacement: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView(),
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: MColors.covidMain)),
          buildCairoEgypt(),
          buildTotalCases(),
          buildVirusIcon(),
          SafeArea(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70.h,
              width: 100.w,
              decoration: BoxDecoration(
                  color: MColors.covidThird,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.h),
                      topLeft: Radius.circular(5.h))),
              child: Column(
                children: [
                  Spacer(),
                  buildCovidCheckContainer(),
                  Spacer(),
                  buildMapContainer(),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      buildProtectionItem(),
                      Spacer(),
                      buildInformationItem(),
                      Spacer(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  GestureDetector buildInformationItem() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, InfoScreen.routeName);
      },
      child: HomeItem(
          icon:
              Icon(FontAwesomeIcons.info, color: MColors.covidMain, size: 4.h),
          text: "Information"),
    );
  }

  GestureDetector buildProtectionItem() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, InfoScreen.routeName);
      },
      child: HomeItem(
          icon: SvgPicture.asset(
            "assets/icons/protection.svg",
            color: MColors.covidMain,
          ),
          text: "Protection"),
    );
  }

  Positioned buildCairoEgypt() {
    return Positioned(
        top: 7.h,
        right: 15.w,
        child: Row(
          children: [
            Text("Cairo, Egypt",
                style:
                    TextStyle(fontFamily: "Plex", color: MColors.covidThird)),
            Icon(Icons.arrow_drop_down, color: MColors.covidThird)
          ],
        ));
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

  Widget buildTotalCases() {
    return FutureBuilder(
        future: presenter.getCovidCases(),
        builder:
            (BuildContext context, AsyncSnapshot<CovidCasesResponse> snapshot) {
          return Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              height: 10.h,
              width: 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  snapshot.hasData
                      ? Container(
                          height: 6.h,
                          child: Text(snapshot.data.cases.toString(),
                              style: TextStyle(
                                  fontFamily: "Plex",
                                  fontWeight: FontWeight.bold,
                                  color: MColors.covidThird,
                                  fontSize: 30.sp)),
                        )
                      : Container(
                          height: 6.h,
                          width: 6.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: .8.h, horizontal: .8.h),
                            child: SpinKitFadingCube(
                              itemBuilder: (context, int index) {
                                return DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                );
                              },
                            ),
                          ),
                        ),
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
        });
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
            // Icon(Icons.arrow_forward_ios, color: MColors.kTextColor, size: 2.h),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildMapContainer() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MapScreen.routeName),
      child: Container(
        height: 15.h,
        width: 90.w,
        padding: EdgeInsets.only(left: 2.w, right: 2.h, top: .5.h),
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
            Container(
                width: 15.h,
                height: 15.h,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                child: SvgPicture.asset(
                  "assets/icons/map.svg",
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Where to go?",
                    style: TextStyle(
                        fontFamily: "Plex",
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp)),
                Text("Check if your destination \nhas COVID-19 danger",
                    style: TextStyle(fontFamily: "Plex", fontSize: 10.sp)),
              ],
            ),
            Spacer(),
            // Icon(Icons.arrow_forward_ios, color: MColors.kTextColor, size: 2.h),
            // Spacer(),
          ],
        ),
      ),
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
