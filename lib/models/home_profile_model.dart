
class HomeProfileModel {
  final Profile? profile;
  final List<Gallery>? gallery;

  HomeProfileModel({
    this.profile,
    this.gallery,
  });

  factory HomeProfileModel.fromJson(Map<String, dynamic> json) => HomeProfileModel(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    gallery: json["gallery"] == null ? [] : List<Gallery>.from(json["gallery"]!.map((x) => Gallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
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

class Profile {
  final String? id;
  final DateTime? dateOfBirth;
  final String? gender;
  final UserId? userId;
  final String? bio;
  final String? datingIntention;
  final String? address;
  final String? favouriteCousing;
  final int? v;
  final String? email;

  Profile({
    this.id,
    this.dateOfBirth,
    this.gender,
    this.userId,
    this.bio,
    this.datingIntention,
    this.address,
    this.favouriteCousing,
    this.v,
    this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["_id"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    gender: json["gender"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    bio: json["bio"],
    datingIntention: json["datingIntention"],
    address: json["address"],
    favouriteCousing: json["favouriteCousing"],
    v: json["__v"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "userId": userId?.toJson(),
    "bio": bio,
    "datingIntention": datingIntention,
    "address": address,
    "favouriteCousing": favouriteCousing,
    "__v": v,
    "email": email,
  };
}

class UserId {
  final String? id;
  final String? name;
  final String? phone;

  UserId({
    this.id,
    this.name,
    this.phone,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
  };
}
