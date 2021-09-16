import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/main_screens/covid_check/covid_chech_provider.dart';
import 'package:covid19/UI/main_screens/covid_check/covid_check_result/model/instruction_model.dart';
import 'package:covid19/UI/main_screens/covid_check/symptom.dart';
import 'package:covid19/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CovidCheckResultScreen extends StatefulWidget {
  static String routeName = "/covidCheckResultScreen";
  @override
  _CovidCheckResultScreenState createState() => _CovidCheckResultScreenState();
}

class _CovidCheckResultScreenState extends State<CovidCheckResultScreen> {
  // double progress;
  @override
  void initState() {
    // progress = 0.0;

    super.initState();
  }

  double progress = 0.0;
  @override
  Widget build(BuildContext _) {
    progress = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
        create: (_) => CovidCheckProvider(),
        builder: (context, child) {
          return Scaffold(
              appBar: buildAppBar(context),
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: Icon(
                        FontAwesomeIcons.shieldAlt,
                        color: progress < .5
                            ? MColors.covidMain
                            : Colors.redAccent,
                        size: 15.h,
                      )),
                    ),
                    SizedBox(height: 5.h),
                    buildCheckResult(context),
                    SizedBox(height: 5.h),
                    buildLearnWhatToDo(),
                    SizedBox(height: 1.h),
                    // InstructionItem(
                    //   text: "COVID-19: Keeping Safe During\nthe Pandemic",
                    // ),
                    // InstructionItem(
                    //   text: "Three Ways You Can Help During\nthe COVID-19 Pandemic",
                    // ),
                    Expanded(
                      // height: 45.h,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: progress > .5
                              ? InstructionData.covidInstructions.length
                              : InstructionData.coldFluInstructions.length,
                          itemBuilder: (context, index) => InstructionItem(
                                text: progress > .5
                                    ? InstructionData.covidInstructions[index]
                                    : InstructionData
                                        .coldFluInstructions[index],
                              )),
                    ),
                  ],
                ),
              ));
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text("Risk of infection",
            style: TextStyle(
                fontFamily: "Plex",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.sp)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: buildButtonBack(context));
  }

  Widget buildCheckResult(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // width: 70.w,
        child: Text(
            progress < .5
                ? "The app has not found any potentially dangerous contacts\nin th last 14 days"
                : "The app has found dangerous contactsin the last 14 days",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Plex",
                height: .15.h,
                // fontWeight: FontWeight.bold,
                // color: MColors.kTextColor,
                fontSize: 16.sp)),
      ),
    );
  }

  Text buildLearnWhatToDo() {
    return Text(
        progress > .5
            ? "How to recover from Covid-19"
            : "How to recover from cold flu",
        // textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: "Plex",
            fontWeight: FontWeight.bold,
            // color: MColors.kTextColor,
            fontSize: 16.sp));
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
}

class InstructionItem extends StatelessWidget {
  const InstructionItem({
    this.text,
    Key key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 85.w,
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
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
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Positioned(
              top: 2.5.h,
              left: 5.w,
              child: Container(
                width: 80.w,
                child: Text(text,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: "Plex", fontSize: 16.sp)),
              )),
          Positioned(
              bottom: -4.h,
              right: -4.w,
              child: Opacity(
                opacity: .8,
                child: Icon(
                  FontAwesomeIcons.virus,
                  color: MColors.covidMain,
                  size: 15.h,
                  // image: AssetImage("assets/images/virus.png"),
                  // height: 20.h,
                  // width: 20.h
                ),
              ))
        ],
      ),
    );
  }
}
