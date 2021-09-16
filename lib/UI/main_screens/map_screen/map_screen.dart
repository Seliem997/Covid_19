import 'dart:math';

import 'package:covid19/UI/components/default_button.dart';
import 'package:covid19/UI/components/loadingIndicator.dart';
import 'package:covid19/UI/main_screens/map_screen/city_data/city_data_presenter.dart';
import 'package:covid19/UI/main_screens/map_screen/covid_numbers/covid_number_presenter.dart';
import 'package:covid19/UI/main_screens/map_screen/covid_numbers/covid_numbers.dart';
import 'package:covid19/UI/main_screens/map_screen/directions_repository.dart';
import 'package:covid19/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'directions_model.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  static String routeName = "/map_screen";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static CameraPosition _intialCameraPosition =
      CameraPosition(zoom: 11.5, target: LatLng(30.033333, 31.233334));
  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition: _intialCameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination
            },
            onLongPress: _addMarker,
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 7.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(3.h),
                    color: Color(0xFFF18E92),
                  ),
                  child: Center(
                    child: Text(
                      "Hold on any place to show COVID-19 Statistics ",
                      style: TextStyle(
                          fontFamily: "Plex",
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
          // Container(
          //   height: 10.h,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: "Search",
          //       disabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(3.h),
          //           borderSide: BorderSide(
          //             color: MColors.covidMain,
          //           )),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(3.h),
          //           borderSide: BorderSide(
          //             color: MColors.covidMain,
          //           )),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: buildRepositionFloatingActionButton(),
    );
  }

  FloatingActionButton buildRepositionFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: MColors.covidThird,
      foregroundColor: MColors.covidMain,
      child: Icon(Icons.center_focus_strong),
      onPressed: () => _googleMapController.animateCamera(_info != null
          ? CameraUpdate.newLatLngBounds(_info.bounds, 100)
          : CameraUpdate.newCameraPosition(_intialCameraPosition)),
    );
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _addMarker(LatLng position) async {
    // if ((_origin == null) || (_origin != null && _destination != null)) {
    //Origin is not set or origin,destination are both set ==> set origin
    CityDataPresenter founder = CityDataPresenter();
    String cityName = await founder.getCityData(
        position.latitude.toString(), position.longitude.toString());
    setState(() {
      _origin = Marker(
          markerId: const MarkerId("origin"),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position);

      showCovidNumbersInThisLocation(context, cityName);
    });
    _destination = null;
    _info = null;
    // } else {
    //   //origin is already set ==> setbdestination
    //   setState(() {
    //     _destination = Marker(
    //         markerId: const MarkerId("destination"),
    //         infoWindow: const InfoWindow(title: 'Destination'),
    //         icon:
    //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //         position: position);
    //   });

    //   // get directions
    //   final directions = await DirectionRepository()
    //       .getDirection(origin: _origin.position, destination: position);
    //   setState(() => _info = directions);
    // }
  }

  showCovidNumbersInThisLocation(BuildContext context, cityName) async {
    showDialog(
        context: context, builder: (context) => LoadingIndicator(size: 11));
    await Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.pop(context));
    print(cityName);
    cityName == null
        ? _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Selected Area not recognized!"),
            backgroundColor: Theme.of(context).errorColor))
        : showLocationInformation(context, cityName);
  }

  Future showLocationInformation(BuildContext context, cityName) {
    Random random = new Random();
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  height: .7.h,
                  width: 7.h,
                  decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(2.h)),
                ),
              ),
              Container(
                child: Text(
                  "Location Selected! ",
                  style: TextStyle(
                      fontFamily: "Plex",
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.redAccent),
                ),
              ),
              Container(
                child: Text(
                  "$cityName",
                  style: TextStyle(
                      fontFamily: "Plex",
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.black),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: EdgeInsets.only(bottom: 2.h, top: 2.h),
                        height: 30.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFF18E92),
                            borderRadius: BorderRadius.circular(3.h)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 8.w),
                            height: 30.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFDC6B70),
                                borderRadius: BorderRadius.circular(3.h)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Cases",
                                  style: TextStyle(
                                      fontFamily: "Plex",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: MColors.covidThird),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Deaths",
                                  style: TextStyle(
                                      fontFamily: "Plex",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: MColors.covidThird),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "Recovered",
                                  style: TextStyle(
                                      fontFamily: "Plex",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: MColors.covidThird),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                      bottom: 5.h,
                      child: Container(
                        width: 65.w,
                        child: DefaultButton(
                          color: MColors.covidThird,
                          textColor: Colors.black,
                          press: () => Navigator.pop(context),
                          text: "Okay",
                        ),
                      )),
                  Positioned(
                    top: 4.h,
                    right: 13.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (random.nextInt(1000) + 500).toString(),
                          style: TextStyle(
                              fontFamily: "Plex",
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: MColors.covidThird),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          random.nextInt(100).toString(),
                          style: TextStyle(
                              fontFamily: "Plex",
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: MColors.covidThird),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          (random.nextInt(1000) + 100).toString(),
                          style: TextStyle(
                              fontFamily: "Plex",
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: MColors.covidThird),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
