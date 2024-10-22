
class MatchUserModel {
  final String? id;
  final UserId? userId1;
  final UserId? userId2;
  final bool? isMatched;
  final String? status;
  final dynamic matchedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MatchUserModel({
    this.id,
    this.userId1,
    this.userId2,
    this.isMatched,
    this.status,
    this.matchedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MatchUserModel.fromJson(Map<String, dynamic> json) => MatchUserModel(
    id: json["_id"],
    userId1: json["userId_1"] == null ? null : UserId.fromJson(json["userId_1"]),
    userId2: json["userId_2"] == null ? null : UserId.fromJson(json["userId_2"]),
    isMatched: json["isMatched"],
    status: json["status"],
    matchedAt: json["matchedAt"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId_1": userId1?.toJson(),
    "userId_2": userId2?.toJson(),
    "isMatched": isMatched,
    "status": status,
    "matchedAt": matchedAt,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  final String? id;
  final String? name;
  final ProfilePictureUrl? profilePictureUrl;
  final String? profileId;

  UserId({
    this.id,
    this.name,
    this.profilePictureUrl,
    this.profileId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
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
