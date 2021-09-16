import 'package:flutter/cupertino.dart';

class Cities {
  List<City> cities = [
    City(name: "Cairo", lat: 30.033333, lon: 31.233334),
    City(name: "Sohag", lat: 26.549999, lon: 31.700001),
    City(name: "Qalyubia", lat: 30.128611, lon: 31.242222),
    City(name: "Dakahlia", lat: 31.192560, lon: 31.520460),
    City(name: "6th of October City", lat: 29.952654, lon: 30.921919),
    City(name: "Asyut", lat: 27.180134, lon: 31.189283),
    City(name: "Mansoura", lat: 31.037933, lon: 31.233334),
    City(name: "Bani Sweif", lat: 29.088413, lon: 31.119085),
    City(name: "Giza", lat: 30.056021, lon: 30.976639),
    City(name: "Damietta", lat: 31.417540, lon: 31.814444),
    City(name: "New Vally", lat: 25.447615, lon: 30.555038),
    City(name: "AlMarg", lat: 30.152102, lon: 31.335730),
    City(name: "Matrouh", lat: 31.354343, lon: 27.237316),
    City(name: "Alexandria", lat: 31.205753, lon: 29.924526),
    City(name: "Luxor", lat: 25.687243, lon: 32.639637),
  ];
}

class City {
  final double lat;
  final double lon;
  final String name;

  City({@required this.name, @required this.lat, @required this.lon});
}
