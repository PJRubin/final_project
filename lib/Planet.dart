// To parse this JSON data, do
//
//     final planet = planetFromJson(jsonString);

import 'dart:convert';

Planet planetFromJson(String str) => Planet.fromJson(json.decode(str));

String planetToJson(Planet data) => json.encode(data.toJson());

class Planet {
  Planet({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.properties,
    this.description,
    this.id,
    this.uid,
    this.v,
  });

  Properties properties;
  String description;
  String id;
  String uid;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    properties: Properties.fromJson(json["properties"]),
    description: json["description"],
    id: json["_id"],
    uid: json["uid"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "properties": properties.toJson(),
    "description": description,
    "_id": id,
    "uid": uid,
    "__v": v,
  };
}

class Properties {
  Properties({
    this.diameter,
    this.rotationPeriod,
    this.orbitalPeriod,
    this.gravity,
    this.population,
    this.climate,
    this.terrain,
    this.surfaceWater,
    this.created,
    this.edited,
    this.name,
    this.url,
  });

  String diameter;
  String rotationPeriod;
  String orbitalPeriod;
  String gravity;
  String population;
  String climate;
  String terrain;
  String surfaceWater;
  DateTime created;
  DateTime edited;
  String name;
  String url;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    diameter: json["diameter"],
    rotationPeriod: json["rotation_period"],
    orbitalPeriod: json["orbital_period"],
    gravity: json["gravity"],
    population: json["population"],
    climate: json["climate"],
    terrain: json["terrain"],
    surfaceWater: json["surface_water"],
    created: DateTime.parse(json["created"]),
    edited: DateTime.parse(json["edited"]),
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "diameter": diameter,
    "rotation_period": rotationPeriod,
    "orbital_period": orbitalPeriod,
    "gravity": gravity,
    "population": population,
    "climate": climate,
    "terrain": terrain,
    "surface_water": surfaceWater,
    "created": created.toIso8601String(),
    "edited": edited.toIso8601String(),
    "name": name,
    "url": url,
  };
}
