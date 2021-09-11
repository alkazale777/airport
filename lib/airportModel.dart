// To parse this JSON data, do
//
//     final airportModel = airportModelFromJson(jsonString);

import 'dart:convert';

List<AirportModel> airportModelFromJson(String str) => List<AirportModel>.from(json.decode(str).map((x) => AirportModel.fromJson(x)));

String airportModelToJson(List<AirportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AirportModel {
  AirportModel({
    this.airportCode,
    this.internationalAirport,
    this.domesticAirport,
    this.regionalAirport,
    this.onlineIndicator,
    this.eticketableAirport,
    this.location,
    this.airportName,
    this.city,
    this.country,
    this.region,
    this.preferredInternationalAirportCode,
  });

  String airportCode;
  bool internationalAirport;
  bool domesticAirport;
  bool regionalAirport;
  bool onlineIndicator;
  bool eticketableAirport;
  Location location;
  String airportName;
  City city;
  Country country;
  Region region;
  String preferredInternationalAirportCode;

  factory AirportModel.fromJson(Map<String, dynamic> json) => AirportModel(
    airportCode: json["airportCode"],
    internationalAirport: json["internationalAirport"],
    domesticAirport: json["domesticAirport"],
    regionalAirport: json["regionalAirport"],
    onlineIndicator: json["onlineIndicator"],
    eticketableAirport: json["eticketableAirport"],
    location: Location.fromJson(json["location"]),
    airportName: json["airportName"],
    city: City.fromJson(json["city"]),
    country: Country.fromJson(json["country"]),
    region: Region.fromJson(json["region"]),
    preferredInternationalAirportCode: json["preferredInternationalAirportCode"] == null ? null : json["preferredInternationalAirportCode"],
  );

  Map<String, dynamic> toJson() => {
    "airportCode": airportCode,
    "internationalAirport": internationalAirport,
    "domesticAirport": domesticAirport,
    "regionalAirport": regionalAirport,
    "onlineIndicator": onlineIndicator,
    "eticketableAirport": eticketableAirport,
    "location": location.toJson(),
    "airportName": airportName,
    "city": city.toJson(),
    "country": country.toJson(),
    "region": region.toJson(),
    "preferredInternationalAirportCode": preferredInternationalAirportCode == null ? null : preferredInternationalAirportCode,
  };
}

class City {
  City({
    this.cityCode,
    this.cityName,
    this.timeZoneName,
  });

  String cityCode;
  String cityName;
  String timeZoneName;

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityCode: json["cityCode"],
    cityName: json["cityName"] == null ? null : json["cityName"],
    timeZoneName: json["timeZoneName"],
  );

  Map<String, dynamic> toJson() => {
    "cityCode": cityCode,
    "cityName": cityName == null ? null : cityName,
    "timeZoneName": timeZoneName,
  };
}

class Country {
  Country({
    this.countryCode,
    this.countryName,
  });

  String countryCode;
  String countryName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryCode: json["countryCode"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "countryName": countryName,
  };
}

class Location {
  Location({
    this.aboveSeaLevel,
    this.latitude,
    this.latitudeRadius,
    this.longitude,
    this.longitudeRadius,
    this.latitudeDirection,
    this.longitudeDirection,
  });

  int aboveSeaLevel;
  double latitude;
  double latitudeRadius;
  double longitude;
  double longitudeRadius;
  LatitudeDirection latitudeDirection;
  LongitudeDirection longitudeDirection;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    aboveSeaLevel: json["aboveSeaLevel"] == null ? null : json["aboveSeaLevel"],
    latitude: json["latitude"].toDouble(),
    latitudeRadius: json["latitudeRadius"].toDouble(),
    longitude: json["longitude"].toDouble(),
    longitudeRadius: json["longitudeRadius"].toDouble(),
    latitudeDirection: json["latitudeDirection"] == null ? null : latitudeDirectionValues.map[json["latitudeDirection"]],
    longitudeDirection: json["longitudeDirection"] == null ? null : longitudeDirectionValues.map[json["longitudeDirection"]],
  );

  Map<String, dynamic> toJson() => {
    "aboveSeaLevel": aboveSeaLevel == null ? null : aboveSeaLevel,
    "latitude": latitude,
    "latitudeRadius": latitudeRadius,
    "longitude": longitude,
    "longitudeRadius": longitudeRadius,
    "latitudeDirection": latitudeDirection == null ? null : latitudeDirectionValues.reverse[latitudeDirection],
    "longitudeDirection": longitudeDirection == null ? null : longitudeDirectionValues.reverse[longitudeDirection],
  };
}

enum LatitudeDirection { S, N }

final latitudeDirectionValues = EnumValues({
  "N": LatitudeDirection.N,
  "S": LatitudeDirection.S
});

enum LongitudeDirection { W, E, N }

final longitudeDirectionValues = EnumValues({
  "E": LongitudeDirection.E,
  "N": LongitudeDirection.N,
  "W": LongitudeDirection.W
});

class Region {
  Region({
    this.regionCode,
    this.regionName,
  });

  RegionCode regionCode;
  RegionName regionName;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    regionCode: regionCodeValues.map[json["regionCode"]],
    regionName: regionNameValues.map[json["regionName"]],
  );

  Map<String, dynamic> toJson() => {
    "regionCode": regionCodeValues.reverse[regionCode],
    "regionName": regionNameValues.reverse[regionName],
  };
}

enum RegionCode { SP, AU, AF, EU, AM, ME, AS }

final regionCodeValues = EnumValues({
  "AF": RegionCode.AF,
  "AM": RegionCode.AM,
  "AS": RegionCode.AS,
  "AU": RegionCode.AU,
  "EU": RegionCode.EU,
  "ME": RegionCode.ME,
  "SP": RegionCode.SP
});

enum RegionName { SOUTH_PACIFIC, AUSTRALIA, AFRICA, EUROPE, AMERICAS, MIDDLE_EAST, ASIA }

final regionNameValues = EnumValues({
  "Africa": RegionName.AFRICA,
  "Americas": RegionName.AMERICAS,
  "Asia": RegionName.ASIA,
  "Australia": RegionName.AUSTRALIA,
  "Europe": RegionName.EUROPE,
  "Middle East": RegionName.MIDDLE_EAST,
  "South Pacific": RegionName.SOUTH_PACIFIC
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
