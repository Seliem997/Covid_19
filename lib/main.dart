import 'package:covid19/UI/user/login/sign_in.dart';
import 'package:covid19/colors.dart';
import 'package:covid19/routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Covid 19',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MColors.covidMain,
        ),
        initialRoute: SignInScreen.routeName,
        routes: Routes.routes,
      ),
    );
  }
}
