import 'package:covid19/UI/components/custom_suffix_icon.dart';
import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/components/loadingIndicator.dart';
import 'package:covid19/UI/main_screens/main_screen/main_screen.dart';
import 'package:covid19/UI/user/register/sign_up_screen.dart';
import 'package:covid19/colors.dart';
import 'package:covid19/constants.dart';
import 'package:covid19/providers/email_sign_in.dart';
import 'package:covid19/providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/signInScreen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool remember = false;
  bool flage = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => EmailSignInProvider()),
      ],
      child: StreamBuilder(
        stream: /*FirebaseAuth.instance.authStateChanges()&*/ FirebaseAuth
            .instance
            .userChanges(),
        builder: (context, snapshot) {
          final googleProvider = Provider.of<GoogleSignInProvider>(context);
          final signInProvider = Provider.of<EmailSignInProvider>(context);
          return Stack(
            alignment: Alignment.center,
            children: [
              Scaffold(
                key: _scaffoldKey,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        child: Column(
                          children: <Widget>[
                            buildLogoArea(),
                            SizedBox(height: 2.h),
                            buildSignInForm(context),
                            SizedBox(height: 5.h),
                            buildSocialLogin(context),
                            SizedBox(height: 7.h),
                            buildDontHaveAnAccount()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              googleProvider.isSigningIn || signInProvider.isLoading
                  ? buildLodingIndicator()
                  : snapshot.hasData
                      ? MainScreen()
                      : Container()
            ],
          );
        },
      ),
    );
  }

  Form buildSignInForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(context),
          SizedBox(height: 2.h),
          buildPasswordFormField(context),
          SizedBox(height: 3.h),
          // FormError(errors: errors),
          Row(
            children: [
              Checkbox(
                activeColor: MColors.covidMain,
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(
                'Remember me',
                style: TextStyle(color: MColors.kTextColor),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   Navigator.pushNamed(
                  //       context, ForgotPasswordScreen.routeName);
                  // });
                },
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                      color: MColors.kTextColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          DefaultButton(
            press: () => submit(context),
            text: 'Login',
          )
        ],
      ),
    );
  }

  Align buildLodingIndicator() {
    return Align(
        alignment: Alignment.bottomCenter, child: LoadingIndicator(size: 11));
  }

  void loading() {}
  Row buildDontHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 4.w),
        ),
        GestureDetector(
          onTap: () {
            // setState(() {
            Navigator.pushNamed(context, SignUpScreen.routeName);
            // });
          },
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 4.w, color: Colors.lightGreen),
          ),
        ),
      ],
    );
  }

  Widget buildSocialLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialLoginWidget(
          onPress: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
          webSiteName: "google",
          icon: "assets/icons/google-icon.svg",
        ),
        SizedBox(height: 1.h),
        buildSocialLoginWidget(
          onPress: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
          webSiteName: "facebook",
          icon: 'assets/icons/facebook-2.svg',
        )
      ],
    );
  }

  Widget buildLogoArea() {
    return Column(
      children: [
        Container(
          height: 15.h,
          width: 20.h,
          child: Image.asset("assets/images/logo-trial.png"),
        ),
        SizedBox(height: .3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "COVID-19 ",
              style: TextStyle(
                  fontFamily: "Plex",
                  fontSize: 2.5.h,
                  fontWeight: FontWeight.bold,
                  color: MColors.covidMain),
            ),
            Text(
              "APP",
              style: TextStyle(
                  fontFamily: "Plex",
                  fontSize: 2.5.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            )
          ],
        ),
      ],
    );
  }

  TextFormField buildPasswordFormField(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      onSaved: (newValue) => provider.userPassword = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter a password";
        else if (value.length < 8)
          return "Password must be more than 8 chars";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      obscureText: true,
      decoration: InputDecoration(
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Lock.svg',
        ),
        labelText: 'Password',
      ),
    );
  }

  TextFormField buildEmailFormField(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      onSaved: (newValue) => provider.userEmail = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter an email";
        else if (!emailValidatorRegExp.hasMatch(value))
          return "You must enter a valid email";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
        labelText: 'Email',
      ),
    );
  }

  Future submit(BuildContext context) async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    provider.isLogin = true;
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final isSuccess = await provider.login();
      if (!isSuccess) {
        final msg = "An error occurred, please check your credential";
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
    }
  }
}

class buildSocialLoginWidget extends StatelessWidget {
  const buildSocialLoginWidget({
    Key key,
    this.webSiteName,
    this.icon,
    this.onPress,
  }) : super(key: key);
  final String webSiteName;
  final String icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        padding: EdgeInsets.all(2.w),
        height: 5.h,
        width: 60.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(5.h),
          // color: Colors.grey[200],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5.h,
              child: SvgPicture.asset(
                icon,
                height: 5.h,
              ),
            ),
            Text(
              "Continue with $webSiteName",
              style: TextStyle(
                  fontFamily: "Plex",
                  color: MColors.kTextColor,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
