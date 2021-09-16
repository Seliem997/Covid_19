import 'package:covid19/UI/main_screens/home/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'model/CovidCasesResponse.dart';

class HomePagePresenter {
  static const String _baseUrl = "https://corona.lmao.ninja/v2/countries/egypt";
  HomeScreen view = HomeScreen();
  final Dio _dio;
  HomePagePresenter({Dio dio}) : _dio = dio ?? Dio();
  Future<CovidCasesResponse> getCovidCases() async {
    BuildContext context;
    // view.showLoading(context);
    final response = await _dio.get(_baseUrl);
    //check response
    if (response.statusCode == 200) {
      print("Request Ok" + response.statusMessage);
      print("Response : " + response.data.toString());
      // view.provider.totalCases =
      //     CovidCasesResponse.fromJson(response.data).cases.toString();
      // view.stopLoading(context);
      return CovidCasesResponse.fromJson(response.data);
      // return CovidCasesResponse.fromJson(response.data);

    } else {
      print("Request Error" + response.statusMessage);
      return null;
    }
  }
}
