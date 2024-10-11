

class ProfileModel {
  final Location? location;
  final String? id;
  final String? email;
  final DateTime? dateOfBirth;
  final String? gender;
  final dynamic locationId;
  final UserId? userId;
  final String? bio;
  final String? datingIntention;
  final String? favouriteCousing;
  final DateTime? createdAt;
  final int? v;

  ProfileModel({
    this.location,
    this.id,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.locationId,
    this.userId,
    this.bio,
    this.datingIntention,
    this.favouriteCousing,
    this.createdAt,
    this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    id: json["_id"],
    email: json["email"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    locationId: json["locationId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    bio: json["bio"],
    datingIntention: json["datingIntention"],
    favouriteCousing: json["favouriteCousing"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "email": email,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "locationId": locationId,
    "userId": userId?.toJson(),
    "bio": bio,
    "datingIntention": datingIntention,
    "favouriteCousing": favouriteCousing,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
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

class UserId {
  final String? id;
  final String? name;
  final String? phone;
  final bool? privacyPolicyAccepted;
  final bool? isVerified;
  final bool? isBlockedByAdmin;
  final ProfilePictureUrl? profilePictureUrl;
  final String? role;
  final int? oneTimeCode;
  final dynamic locationId;
  final String? profileId;
  final dynamic fcmToken;
  final bool? isOnline;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserId({
    this.id,
    this.name,
    this.phone,
    this.privacyPolicyAccepted,
    this.isVerified,
    this.isBlockedByAdmin,
    this.profilePictureUrl,
    this.role,
    this.oneTimeCode,
    this.locationId,
    this.profileId,
    this.fcmToken,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    privacyPolicyAccepted: json["privacyPolicyAccepted"],
    isVerified: json["isVerified"],
    isBlockedByAdmin: json["isBlockedByAdmin"],
    profilePictureUrl: json["profilePictureUrl"] == null ? null : ProfilePictureUrl.fromJson(json["profilePictureUrl"]),
    role: json["role"],
    oneTimeCode: json["oneTimeCode"],
    locationId: json["locationId"],
    profileId: json["profileId"],
    fcmToken: json["fcmToken"],
    isOnline: json["isOnline"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "privacyPolicyAccepted": privacyPolicyAccepted,
    "isVerified": isVerified,
    "isBlockedByAdmin": isBlockedByAdmin,
    "profilePictureUrl": profilePictureUrl?.toJson(),
    "role": role,
    "oneTimeCode": oneTimeCode,
    "locationId": locationId,
    "profileId": profileId,
    "fcmToken": fcmToken,
    "isOnline": isOnline,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ProfilePictureUrl {
  final String? publicFileUrl;
  final String? path;

  ProfilePictureUrl({
    this.publicFileUrl,
    this.path,
  });

  factory ProfilePictureUrl.fromJson(Map<String, dynamic> json) => ProfilePictureUrl(
    publicFileUrl: json["publicFileURL"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "path": path,
  };
}
