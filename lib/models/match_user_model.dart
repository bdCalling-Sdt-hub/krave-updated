// To parse this JSON data, do
//
//     final matchUserModel = matchUserModelFromJson(jsonString);

import 'dart:convert';

MatchUserModel matchUserModelFromJson(String str) => MatchUserModel.fromJson(json.decode(str));

String matchUserModelToJson(MatchUserModel data) => json.encode(data.toJson());

class MatchUserModel {
  final String? id;
  final bool? isMatched;
  final String? status;
  final dynamic matchedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  MatchUserModel({
    this.id,
    this.isMatched,
    this.status,
    this.matchedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory MatchUserModel.fromJson(Map<String, dynamic> json) => MatchUserModel(
    id: json["_id"],
    isMatched: json["isMatched"],
    status: json["status"],
    matchedAt: json["matchedAt"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isMatched": isMatched,
    "status": status,
    "matchedAt": matchedAt,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? name;
  final ProfilePictureUrl? profilePictureUrl;
  final String? profileId;

  User({
    this.id,
    this.name,
    this.profilePictureUrl,
    this.profileId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    profilePictureUrl: json["profilePictureUrl"] == null ? null : ProfilePictureUrl.fromJson(json["profilePictureUrl"]),
    profileId: json["profileId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profilePictureUrl": profilePictureUrl?.toJson(),
    "profileId": profileId,
  };
}

class ProfilePictureUrl {
  final String? path;
  final String? originalName;
  final String? publicFileUrl;

  ProfilePictureUrl({
    this.path,
    this.originalName,
    this.publicFileUrl,
  });

  factory ProfilePictureUrl.fromJson(Map<String, dynamic> json) => ProfilePictureUrl(
    path: json["path"],
    originalName: json["originalName"],
    publicFileUrl: json["publicFileURL"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "originalName": originalName,
    "publicFileURL": publicFileUrl,
  };
}
