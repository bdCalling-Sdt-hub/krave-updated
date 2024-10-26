

class CongratulationsMatchModel {
  final Location? location;
  final String? id;
  final DateTime? dateOfBirth;
  final String? gender;
  final dynamic locationId;
  final UserId? userId;
  final String? bio;
  final String? datingIntention;
  final String? address;
  final String? favouriteCousing;
  final DateTime? createdAt;
  final int? v;
  final int? distance;
  final DateTime? updatedAt;

  CongratulationsMatchModel({
    this.location,
    this.id,
    this.dateOfBirth,
    this.gender,
    this.locationId,
    this.userId,
    this.bio,
    this.datingIntention,
    this.address,
    this.favouriteCousing,
    this.createdAt,
    this.v,
    this.distance,
    this.updatedAt,
  });

  factory CongratulationsMatchModel.fromJson(Map<String, dynamic> json) => CongratulationsMatchModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    id: json["_id"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    locationId: json["locationId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    bio: json["bio"],
    datingIntention: json["datingIntention"],
    address: json["address"],
    favouriteCousing: json["favouriteCousing"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    v: json["__v"],
    distance: json["distance"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "locationId": locationId,
    "userId": userId?.toJson(),
    "bio": bio,
    "datingIntention": datingIntention,
    "address": address,
    "favouriteCousing": favouriteCousing,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "distance": distance,
    "updatedAt": updatedAt?.toIso8601String(),
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
  final ProfilePictureUrl? profilePictureUrl;

  UserId({
    this.id,
    this.name,
    this.phone,
    this.profilePictureUrl,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    profilePictureUrl: json["profilePictureUrl"] == null ? null : ProfilePictureUrl.fromJson(json["profilePictureUrl"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "profilePictureUrl": profilePictureUrl?.toJson(),
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
