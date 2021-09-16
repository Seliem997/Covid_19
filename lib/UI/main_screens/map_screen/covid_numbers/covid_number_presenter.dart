import 'package:covid19/UI/main_screens/map_screen/covid_numbers/covid_numbers.dart';

class CityFounder {
  Cities cities = Cities();
  Future<City> getCity(double lat, double lon) async {
    await cities.cities.forEach((element) {
      if (element.lat >= lat && element.lon >= lon) return element;
    });
    return null;
  }

  bool isNear(double x, double y) {
    // if(x==y || x-y >=.5 || x-y>=.05 || x-y >=.5 || x-y>=.05 ||)
  }
}
