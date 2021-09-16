import 'dart:io';

import 'package:covid19/UI/components/custom_suffix_icon.dart';
import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/components/loadingIndicator.dart';
import 'package:covid19/UI/components/social_card.dart';
import 'package:covid19/UI/main_screens/more_screen/more_screen.dart';
import 'package:covid19/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid19/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  static String routeName = '/editProfileScreen';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String email, password, name, number;

  User user = FirebaseAuth.instance.currentUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  PickedFile pickedFile;
  String imageUrl;

  @override
  void initState() {
    nameController.text = user.displayName;
    emailController.text = user.email;
    phoneNumController.text = user.phoneNumber;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildButtonBack(context),
              buildProfileBar(),
              Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    width: double.infinity,
                    child: Column(
                      children: [
                        buildNameTextFormField(),
                        // SizedBox(height: 2.h),
                        // buildAgeTextFormField(),
                        SizedBox(height: 2.h),
                        buildEmailTextFormField(),
                        SizedBox(height: 5.h),
                        DefaultButton(
                          text: 'Save',
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              FocusScope.of(context).unfocus();
                              _formKey.currentState.save();
                              showLoading(context);
                              await user.updateDisplayName(name);
                              await user.updateEmail(email);
                              await user.reload();
                              user = FirebaseAuth.instance.currentUser;

                              Navigator.pop(context);
                              Navigator.pop(context);

                              // print(user.photoURL);

                              // Navigator.pushNamed(
                              //     context, ComlpleteProfileScreen.routeName);

                            }
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }

  TextFormField buildAgeTextFormField() {
    return TextFormField(
      controller: phoneNumController,
      onSaved: (newValue) => number = newValue,
      validator: (value) {
        if (value.isEmpty) return "You must enter your phone number";
        return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Icon(FontAwesomeIcons.calendarAlt),
        ),
        labelText: 'Phone',
      ),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      controller: emailController,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter an email";
        else if (!emailValidatorRegExp.hasMatch(value))
          return "You must enter a valid email";

        return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
        labelText: 'Email',
      ),
    );
  }

  TextFormField buildNameTextFormField() {
    return TextFormField(
      controller: nameController,
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        if (value.isEmpty) return "You must enter your name";

        return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/User.svg',
        ),
        labelText: 'Name',
      ),
    );
  }

  Align buildBackToLoginArrow(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios, size: 2.h),
              Text(
                "login",
                style: TextStyle(color: MColors.kTextColor),
              )
            ],
          )),
    );
  }

  Future showLoading(context) {
    return showDialog(
      context: context,
      builder: (context) => LoadingIndicator(size: 11),
    );
  }

  Widget buildProfileBar() {
    return Container(
      height: 25.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Container(
                width: 40.w,
                child: GestureDetector(
                  onTap: () async {
                    var pickedImage = await ImagePicker().getImage(
                        source: ImageSource.gallery, //pick from device gallery
                        maxWidth: 1920,
                        maxHeight: 1200, //specify size and quality
                        imageQuality: 80); //so image_picker will resize for you
                    Reference ref = FirebaseStorage.instance
                        .ref()
                        .child("unique_name.jpg"); //generate a unique name
                    showLoading(context);
                    await ref.putFile(
                        File(pickedImage.path)); //you need to add path here
                    imageUrl = await ref.getDownloadURL();
                    print(imageUrl);
                    await user.updatePhotoURL(imageUrl).whenComplete(
                        () => user = FirebaseAuth.instance.currentUser);
                    setState(() {
                      print("done");
                    });
                    await Future.delayed(Duration(seconds: 2));

                    Navigator.pop(context);

                    // user.reload();
                  },
                  child: CircleAvatar(
                    radius: 50.h,
                    backgroundColor: MColors.covidThird,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL)
                        : AssetImage(
                            "assets/images/ic_launcher.png",
                          ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 3.h,
            right: 30.w,
            child: GestureDetector(
              onTap: () {
                // provider2?.getImage(mPresenter);
              },
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: new BoxDecoration(
                  color: MColors.covidMain.withOpacity(.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 4.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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

  buildSocialLogin() {
    return Column(
      children: [
        Text(
          "Or you can register with",
          style: TextStyle(fontFamily: "Plex", color: MColors.kTextColor),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialCard(
              icon: 'assets/icons/google-icon.svg',
              press: () {},
            ),
            SocialCard(
              icon: 'assets/icons/facebook-2.svg',
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}
