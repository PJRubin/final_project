// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

class Character {
  Character({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
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
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.created,
    this.edited,
    this.name,
    this.homeworld,
    this.url,
  });

  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  DateTime created;
  DateTime edited;
  String name;
  String homeworld;
  String url;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    height: json["height"],
    mass: json["mass"],
    hairColor: json["hair_color"],
    skinColor: json["skin_color"],
    eyeColor: json["eye_color"],
    birthYear: json["birth_year"],
    gender: json["gender"],
    created: DateTime.parse(json["created"]),
    edited: DateTime.parse(json["edited"]),
    name: json["name"],
    homeworld: json["homeworld"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "mass": mass,
    "hair_color": hairColor,
    "skin_color": skinColor,
    "eye_color": eyeColor,
    "birth_year": birthYear,
    "gender": gender,
    "created": created.toIso8601String(),
    "edited": edited.toIso8601String(),
    "name": name,
    "homeworld": homeworld,
    "url": url,
  };
}
