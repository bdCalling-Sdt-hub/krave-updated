
class MatchUserModel {
  final String? id;
  final bool? isMatched;
  final DateTime? createdAt;
  final String? matchUserModelId;
  final String? name;
  final dynamic age;
  final DateTime? dateOfBirth;
  final ProfilePicture? profilePicture;
  final String? address;
  final String? conversationId;

  MatchUserModel({
    this.id,
    this.isMatched,
    this.createdAt,
    this.matchUserModelId,
    this.name,
    this.age,
    this.dateOfBirth,
    this.profilePicture,
    this.address,
    this.conversationId,
  });

  factory MatchUserModel.fromJson(Map<String, dynamic> json) => MatchUserModel(
    id: json["_id"],
    isMatched: json["isMatched"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    matchUserModelId: json["id"],
    name: json["name"],
    age: json["age"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
    address: json["address"],
    conversationId: json["conversationId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isMatched": isMatched,
    "createdAt": createdAt?.toIso8601String(),
    "id": matchUserModelId,
    "name": name,
    "age": age,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "profilePicture": profilePicture?.toJson(),
    "address": address,
    "conversationId": conversationId,
  };
}

class ProfilePicture {
  final String? path;
  final String? originalName;
  final String? publicFileUrl;

  ProfilePicture({
    this.path,
    this.originalName,
    this.publicFileUrl,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
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
