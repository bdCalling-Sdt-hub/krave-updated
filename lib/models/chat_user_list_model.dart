
class ChatUserListModel {
  final String? id;
  final bool? isBlocked;
  final List<Participant>? participants;
  final UnreadMessages? unreadMessages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final LastMessage? lastMessage;

  ChatUserListModel({
    this.id,
    this.isBlocked,
    this.participants,
    this.unreadMessages,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastMessage,
  });

  factory ChatUserListModel.fromJson(Map<String, dynamic> json) => ChatUserListModel(
    id: json["_id"],
    isBlocked: json["isBlocked"],
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    unreadMessages: json["unreadMessages"] == null ? null : UnreadMessages.fromJson(json["unreadMessages"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isBlocked": isBlocked,
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "unreadMessages": unreadMessages?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "lastMessage": lastMessage?.toJson(),
  };
}

class LastMessage {
  final String? id;
  final String? message;
  final DateTime? createdAt;

  LastMessage({
    this.id,
    this.message,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    message: json["message"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Participant {
  final String? id;
  final String? name;
  final String? phone;
  final bool? isOnline;
  final ProfilePictureUrl? profilePictureUrl;

  Participant({
    this.id,
    this.name,
    this.phone,
    this.isOnline,
    this.profilePictureUrl,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    isOnline: json["isOnline"],
    profilePictureUrl: json["profilePictureUrl"] == null ? null : ProfilePictureUrl.fromJson(json["profilePictureUrl"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "isOnline": isOnline,
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

class UnreadMessages {
  UnreadMessages();

  factory UnreadMessages.fromJson(Map<String, dynamic> json) => UnreadMessages(
  );

  Map<String, dynamic> toJson() => {
  };
}
