// To parse this JSON data, do
//
//     final homeFeedModel = homeFeedModelFromJson(jsonString);

import 'dart:convert';

HomeFeedModel homeFeedModelFromJson(String str) => HomeFeedModel.fromJson(json.decode(str));

String homeFeedModelToJson(HomeFeedModel data) => json.encode(data.toJson());

class HomeFeedModel {
  final String? id;
  final String? name;
  final int? age;
  final List<Gallery>? gallery;
  final Location? location;
  final dynamic address;

  HomeFeedModel({
    this.id,
    this.name,
    this.age,
    this.gallery,
    this.location,
    this.address,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) => HomeFeedModel(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    gallery: json["gallery"] == null ? [] : List<Gallery>.from(json["gallery"]!.map((x) => Gallery.fromJson(x))),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "location": location?.toJson(),
    "address": address,
  };
}

class Gallery {
  final String? imageUrl;

  Gallery({
    this.imageUrl,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
