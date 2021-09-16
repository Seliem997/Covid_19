import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/components/loadingIndicator.dart';
import 'package:covid19/UI/main_screens/covid_check/covid_chech_provider.dart';
import 'package:covid19/UI/main_screens/covid_check/covid_check_result/covid_check_result.dart';
import 'package:covid19/UI/main_screens/covid_check/symptom.dart';
import 'package:covid19/UI/main_screens/map_screen/map_screen.dart';
import 'package:covid19/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CovidCheckScreen extends StatefulWidget {
  static String routeName = "/covidCheckScreen";
  @override
  _CovidCheckScreenState createState() => _CovidCheckScreenState();
}

class _CovidCheckScreenState extends State<CovidCheckScreen> {
  // double progress;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
      create: (_) => CovidCheckProvider(),
      builder: (context, child) => Scaffold(
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: MColors.covidMain)),
            buildButtonBack(context),
            buildSymptomCheck(),
            buildProgressBar(context),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                decoration: BoxDecoration(
                    color: MColors.covidThird,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.h),
                        topLeft: Radius.circular(5.h))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        buildMainTitleText(),
                        buildSymptoms(context),
                      ],
                    ),
                    buildNextButton(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildButtonBack(BuildContext context) {
    return Positioned(
      top: 6.h,
      left: 5.w,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.all(1.h),
          width: 5.h,
          height: 5.h,
          child: Icon(Icons.arrow_back_ios, color: MColors.covidThird),
        ),
      ),
    );
  }

  Positioned buildProgressBar(BuildContext context) {
    final provider = Provider.of<CovidCheckProvider>(context, listen: false);
    return Positioned(
        top: 22.h,
        child: LinearPercentIndicator(
            width: 75.w,
            lineHeight: 14.0,
            percent: provider.progress,
            backgroundColor: MColors.covidThird.withOpacity(.5),
            progressColor: provider.progress > 0.75
                ? Colors.red
                : provider.progress > .50
                    ? Colors.amber
                    : provider.progress > .25
                        ? Colors.white
                        : Colors.green));
  }

  Positioned buildNextButton(BuildContext context) {
    return Positioned(
      bottom: 1.h,
      right: 5.w,
      child: SizedBox(
        width: 40.w,
        child: DefaultButton(
          text: "Next",
          press: () {
            final provider =
                Provider.of<CovidCheckProvider>(context, listen: false);
            provider.progress == 0.0
                ? _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Please Select one of your Symptoms!"),
                    backgroundColor: Theme.of(context).errorColor,
                  ))
                : showLoading(context, provider.progress);
            // Navigator.pushNamed(
            //     context, CovidCheckResultScreen.routeName));
          },
        ),
      ),
    );
  }

  Future showLoading(BuildContext context, double progress) async {
    showDialog(
      context: context,
      builder: (context) => LoadingIndicator(size: 11),
    );
    await Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.pop(context));
    Navigator.pushNamed(context, CovidCheckResultScreen.routeName,
        arguments: progress);
  }

  Container buildMainTitleText() {
    return Container(
      height: 15.h,
      width: 90.w,
      padding: EdgeInsets.only(left: 2.w, right: 2.h, top: 2.h),
      decoration: BoxDecoration(

          // border: Border.all()
          ),
      child: Text(
          "Check all symptoms you have experienced in the past 2 weeks:",
          style: TextStyle(
              fontFamily: "Plex",
              fontWeight: FontWeight.bold,
              fontSize: 18.sp)),
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

  Positioned buildSymptomCheck() {
    return Positioned(
      top: 14.h,
      left: 13.w,
      child: Text("Covid Check",
          style: TextStyle(
              fontFamily: "Plex",
              fontWeight: FontWeight.bold,
              color: MColors.covidThird,
              fontSize: 30.sp)),
    );
  }

  Widget buildSymptoms(BuildContext context) {
    final provider = Provider.of<CovidCheckProvider>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SymptomItem(symptom: provider.fever, context: context),
              Spacer(),
              SymptomItem(
                  symptom: provider.shortnessOfBreathing, context: context),
              Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              SymptomItem(symptom: provider.chestSeizures, context: context),
              Spacer(),
              SymptomItem(symptom: provider.dryCough, context: context),
              Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              SymptomItem(symptom: provider.diarrhea, context: context),
              Spacer(),
              SymptomItem(symptom: provider.painsAndSoreness, context: context),
              Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              SymptomItem(symptom: provider.exhausting, context: context),
              Spacer(),
              SymptomItem(symptom: provider.fatigue, context: context),
              Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              SymptomItem(symptom: provider.headache, context: context),
              Spacer(),
              SymptomItem(symptom: provider.painInchest, context: context),
              Spacer(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              SymptomItem(symptom: provider.sneezing, context: context),
              Spacer(),
              SymptomItem(symptom: provider.soreThroat, context: context),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  checkSymptom(List<Symptom> symptoms, BuildContext context) {
    final provider = Provider.of<CovidCheckProvider>(context, listen: true);
    provider.checkSymptom(symptoms);
    // progress = 0.0;
    // symptoms.forEach((symptom) {
    //   if (symptom.isSelected == true) progress = progress + 0.25;
    // });
  }

  Widget SymptomItem({@required Symptom symptom, BuildContext context}) {
    final provider = Provider.of<CovidCheckProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        symptom.isSelected = !symptom.isSelected;
        provider.checkSymptom([
          provider.fever,
          provider.shortnessOfBreathing,
          provider.fatigue,
          provider.dryCough,
          provider.chestSeizures,
          provider.diarrhea,
          provider.exhausting,
          provider.headache,
          provider.painInchest,
          provider.painsAndSoreness,
          provider.sneezing,
          provider.soreThroat,
        ]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200],
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 5))
          ],
          color: symptom.isSelected ? MColors.covidMain : MColors.covidFifth,
          borderRadius: BorderRadius.circular(1.h),

          // border: Border.all()
        ),
        child: Text(symptom.name,
            style: TextStyle(
                fontFamily: "Plex",
                fontWeight: FontWeight.bold,
                color:
                    symptom.isSelected ? MColors.covidThird : MColors.covidMain,
                fontSize: 12.sp)),
      ),
    );
  }
}
