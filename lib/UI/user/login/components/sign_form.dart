import 'package:covid19/UI/components/custom_suffix_icon.dart';
import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/providers/email_sign_in.dart';
import 'package:covid19/colors.dart';
import 'package:covid19/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String email, password;
  bool remember = false;
  bool flage = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ChangeNotifierProvider(
        create: (context) => EmailSignInProvider(),
        child: Column(
          children: <Widget>[
            buildEmailFormField(),
            SizedBox(height: 2.h),
            buildPasswordFormField(),
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
              press: () => submit(),
              text: 'Login',
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
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

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    provider.isLogin = true;
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //   final isSuccess = await provider.login();
      //   if (isSuccess) {
      //     Navigator.of(context).pop();
      //   } else {
      //     final msg = "An error occurred, please check your credential";
      //     _scaffoldKey.currentState.showSnackBar(SnackBar(
      //       content: Text(msg),
      //       backgroundColor: Theme.of(context).errorColor,
      //     ));
      //   }
    }
  }
}
