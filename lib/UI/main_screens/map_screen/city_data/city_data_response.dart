class CityDataResponse {
  double latitude;
  double longitude;
  String lookupSource;
  String plusCode;
  String localityLanguageRequested;
  String continent;
  String continentCode;
  String countryName;
  String countryCode;
  String principalSubdivision;
  String principalSubdivisionCode;
  String city;
  String locality;
  String postcode;
  LocalityInfo localityInfo;

  CityDataResponse(
      {this.latitude,
      this.longitude,
      this.lookupSource,
      this.plusCode,
      this.localityLanguageRequested,
      this.continent,
      this.continentCode,
      this.countryName,
      this.countryCode,
      this.principalSubdivision,
      this.principalSubdivisionCode,
      this.city,
      this.locality,
      this.postcode,
      this.localityInfo});

  CityDataResponse.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    lookupSource = json['lookupSource'];
    plusCode = json['plusCode'];
    localityLanguageRequested = json['localityLanguageRequested'];
    continent = json['continent'];
    continentCode = json['continentCode'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    principalSubdivision = json['principalSubdivision'];
    principalSubdivisionCode = json['principalSubdivisionCode'];
    city = json['city'];
    locality = json['locality'];
    postcode = json['postcode'];
    localityInfo = json['localityInfo'] != null
        ? new LocalityInfo.fromJson(json['localityInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['lookupSource'] = this.lookupSource;
    data['plusCode'] = this.plusCode;
    data['localityLanguageRequested'] = this.localityLanguageRequested;
    data['continent'] = this.continent;
    data['continentCode'] = this.continentCode;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['principalSubdivision'] = this.principalSubdivision;
    data['principalSubdivisionCode'] = this.principalSubdivisionCode;
    data['city'] = this.city;
    data['locality'] = this.locality;
    data['postcode'] = this.postcode;
    if (this.localityInfo != null) {
      data['localityInfo'] = this.localityInfo.toJson();
    }
    return data;
  }
}

class LocalityInfo {
  List<Administrative> administrative;
  List<Informative> informative;

  LocalityInfo({this.administrative, this.informative});

  LocalityInfo.fromJson(Map<String, dynamic> json) {
    if (json['administrative'] != null) {
      administrative = new List<Administrative>();
      json['administrative'].forEach((v) {
        administrative.add(new Administrative.fromJson(v));
      });
    }
    if (json['informative'] != null) {
      informative = new List<Informative>();
      json['informative'].forEach((v) {
        informative.add(new Informative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.administrative != null) {
      data['administrative'] =
          this.administrative.map((v) => v.toJson()).toList();
    }
    if (this.informative != null) {
      data['informative'] = this.informative.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Administrative {
  int order;
  int adminLevel;
  String name;
  String description;
  String isoName;
  String isoCode;
  String wikidataId;
  int geonameId;

  Administrative(
      {this.order,
      this.adminLevel,
      this.name,
      this.description,
      this.isoName,
      this.isoCode,
      this.wikidataId,
      this.geonameId});

  Administrative.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    adminLevel = json['adminLevel'];
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['adminLevel'] = this.adminLevel;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isoName'] = this.isoName;
    data['isoCode'] = this.isoCode;
    data['wikidataId'] = this.wikidataId;
    data['geonameId'] = this.geonameId;
    return data;
  }
}

class Informative {
  int order;
  String name;
  String description;
  String isoCode;
  String wikidataId;
  int geonameId;

  Informative(
      {this.order,
      this.name,
      this.description,
      this.isoCode,
      this.wikidataId,
      this.geonameId});

  Informative.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    name = json['name'];
    description = json['description'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['name'] = this.name;
    data['description'] = this.description;
    data['isoCode'] = this.isoCode;
    data['wikidataId'] = this.wikidataId;
    data['geonameId'] = this.geonameId;
    return data;
  }
}
