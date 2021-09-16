import 'package:covid19/UI/main_screens/map_screen/city_data/city_data_response.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class CityDataPresenter {
  static String _baseUrl(String lat, String lon) =>
      "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=en";
  String city;
  final Dio _dio;
  CityDataPresenter({Dio dio}) : _dio = dio ?? Dio();
  Future<String> getCityData(String lat, String lon) async {
    final response = await _dio.get(_baseUrl(lat, lon));
    //check response
    if (response.statusCode == 200) {
      print("Request Ok" + response.statusMessage);
      print("Response :: " + response.data.toString());
      city = CityDataResponse.fromJson(response.data).locality;
      print(response.data);
      return city;
      // return CovidCasesResponse.fromJson(response.data);
    } else {
      print("Request Error" + response.statusMessage);
      return null;
    }
  }
}
