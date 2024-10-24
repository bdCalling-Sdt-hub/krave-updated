
class MessageModel {
  final String? id;
  final String? conversationId;
  final String? senderId;
  final dynamic receiverId;
  final String? messageType;
  final String? message;
  final List<FileElement>? file;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  MessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.messageType,
    this.message,
    this.file,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["_id"],
    conversationId: json["conversationId"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    messageType: json["messageType"],
    message: json["message"],
    file: json["file"] == null ? [] : List<FileElement>.from(json["file"]!.map((x) => FileElement.fromJson(x))),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "conversationId": conversationId,
    "senderId": senderId,
    "receiverId": receiverId,
    "messageType": messageType,
    "message": message,
    "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class FileElement {
  final String? publicFileUrl;
  final String? originalName;
  final String? path;
  final String? mimetype;
  final String? id;

  FileElement({
    this.publicFileUrl,
    this.originalName,
    this.path,
    this.mimetype,
    this.id,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    publicFileUrl: json["publicFileURL"],
    originalName: json["originalName"],
    path: json["path"],
    mimetype: json["mimetype"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileURL": publicFileUrl,
    "originalName": originalName,
    "path": path,
    "mimetype": mimetype,
    "_id": id,
  };
}



//
//
// class MessageModel {
//   final String? id;
//   final String? conversationId;
//   final String? senderId;
//   final ReceiverId? receiverId;
//   final String? messageType;
//   final String? message;
//   final List<FileElement>? file;
//   final bool? isDeleted;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//
//   MessageModel({
//     this.id,
//     this.conversationId,
//     this.senderId,
//     this.receiverId,
//     this.messageType,
//     this.message,
//     this.file,
//     this.isDeleted,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//     id: json["_id"],
//     conversationId: json["conversationId"],
//     senderId: json["senderId"],
//     receiverId: json["receiverId"] == null ? null : ReceiverId.fromJson(json["receiverId"]),
//     messageType: json["messageType"],
//     message: json["message"],
//     file: json["file"] == null ? [] : List<FileElement>.from(json["file"]!.map((x) => FileElement.fromJson(x))),
//     isDeleted: json["isDeleted"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "conversationId": conversationId,
//     "senderId": senderId,
//     "receiverId": receiverId?.toJson(),
//     "messageType": messageType,
//     "message": message,
//     "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x.toJson())),
//     "isDeleted": isDeleted,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class FileElement {
//   final String? publicFileUrl;
//   final String? originalName;
//   final String? path;
//   final dynamic mimetype;
//   final String? id;
//
//   FileElement({
//     this.publicFileUrl,
//     this.originalName,
//     this.path,
//     this.mimetype,
//     this.id,
//   });
//
//   factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
//     publicFileUrl: json["publicFileURL"],
//     originalName: json["originalName"],
//     path: json["path"],
//     mimetype: json["mimetype"],
//     id: json["_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "publicFileURL": publicFileUrl,
//     "originalName": originalName,
//     "path": path,
//     "mimetype": mimetype,
//     "_id": id,
//   };
// }
//
// class ReceiverId {
//   final String? id;
//   final String? name;
//   final ProfilePictureUrl? profilePictureUrl;
//
//   ReceiverId({
//     this.id,
//     this.name,
//     this.profilePictureUrl,
//   });
//
//   factory ReceiverId.fromJson(Map<String, dynamic> json) => ReceiverId(
//     id: json["_id"],
//     name: json["name"],
//     profilePictureUrl: json["profilePictureUrl"] == null ? null : ProfilePictureUrl.fromJson(json["profilePictureUrl"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "profilePictureUrl": profilePictureUrl?.toJson(),
//   };
// }
//
// class ProfilePictureUrl {
//   final String? path;
//   final String? originalName;
//   final String? publicFileUrl;
//
//   ProfilePictureUrl({
//     this.path,
//     this.originalName,
//     this.publicFileUrl,
//   });
//
//   factory ProfilePictureUrl.fromJson(Map<String, dynamic> json) => ProfilePictureUrl(
//     path: json["path"],
//     originalName: json["originalName"],
//     publicFileUrl: json["publicFileURL"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "path": path,
//     "originalName": originalName,
//     "publicFileURL": publicFileUrl,
//   };
// }
