

class NotificationModel {
  final String? id;
  final String? message;
  final String? notificationFor;
  final String? notificationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationModel({
    this.id,
    this.message,
    this.notificationFor,
    this.notificationId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["_id"],
    message: json["message"],
    notificationFor: json["notificationFor"],
    notificationId: json["notificationId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "notificationFor": notificationFor,
    "notificationId": notificationId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
