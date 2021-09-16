import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/main_screens/info_screen/model/info_model.dart';
import 'package:covid19/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'info_detais/info_details_screen.dart';

class InfoScreen extends StatelessWidget {
  static String routeName = "/InofScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildAppBar(context),
              Container(
                margin: EdgeInsets.only(bottom: 1.h),
                decoration: BoxDecoration(
                    color: MColors.covidMain.withOpacity(.1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2.h),
                        bottomRight: Radius.circular(2.h))),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                        width: 40.w,
                        child: DefaultButton(
                          text: "Covid Numbers",
                          size: 12.sp,
                          press: () {
                            launch(
                                "https://www.google.com/search?q=%D8%A7%D8%B9%D8%AF%D8%A7%D8%AF+%D8%A7%D8%B5%D8%A7%D8%A8%D8%A7%D8%AA+%D9%83%D9%88%D8%B1%D9%88%D9%86%D8%A7&oq=%D8%A7%D8%B9%D8%AF%D8%A7%D8%AF+%D8%A7%D8%B5%D8%A7%D8%A8%D8%A7&aqs=chrome.0.0j69i57j0l8.9862j0j4&sourceid=chrome&ie=UTF-8");
                          },
                          color: MColors.covidMain,
                        )),
                    SizedBox(width: 1.h),
                    SizedBox(
                      width: 40.w,
                      child: DefaultButton(
                        text: "Covid Vaccine",
                        size: 12.sp,
                        press: () {
                          launch("https://egcovac.mohp.gov.eg/#/home");
                        },
                        color: MColors.covidMain,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: Info.information.length,
                      itemBuilder: (context, index) => InfoItem(
                            info: Info.information[index],
                          )))
            ]),
          ),
        ),
      ),
    );
  }

  Center buildAppBar(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        child: Row(
          children: [
            buildButtonBack(context),
            Spacer(),
            Text(
              "Information",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: "Plex",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget buildButtonBack(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(1.h),
        width: 5.h,
        height: 5.h,
        child: Icon(Icons.arrow_back_ios, color: MColors.covidMain),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key key,
    this.info,
  }) : super(key: key);
  final Info info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      margin: EdgeInsets.only(bottom: 2.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h, top: 2.h),
              height: 25.h,
              width: 90.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(info.assetImage), fit: BoxFit.cover),
                  color: MColors.covidMain,
                  borderRadius: BorderRadius.circular(3.h)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.h),
            child: Text(
              info.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: "Plex",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.h),
            child: Text(
              info.description,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "Plex",
                  // fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(
            height: 4.h,
            child: DefaultButton(
              press: () {
                Navigator.pushNamed(context, InfoItemDetailsScreen.routeName,
                    arguments: info);
              },
              text: "More",
            ),
          )
        ],
      ),
    );
  }
}
