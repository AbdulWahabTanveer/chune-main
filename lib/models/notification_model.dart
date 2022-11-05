class NotificationModel {
  final String chuneImage;
  final String userImage;
  final String message;
  final String type;
  final String userId;
  final String chuneId;
  final DateTime timeStamp;

//<editor-fold desc="Data Methods">

  const NotificationModel({
    this.chuneImage,
    this.userImage,
    this.message,
    this.type,
    this.userId,
    this.chuneId,
    this.timeStamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationModel &&
          runtimeType == other.runtimeType &&
          chuneImage == other.chuneImage &&
          userImage == other.userImage &&
          message == other.message &&
          type == other.type &&
          userId == other.userId &&
          chuneId == other.chuneId &&
          timeStamp == other.timeStamp);

  @override
  int get hashCode =>
      chuneImage.hashCode ^
      userImage.hashCode ^
      message.hashCode ^
      type.hashCode ^
      userId.hashCode ^
      chuneId.hashCode ^
      timeStamp.hashCode;

  @override
  String toString() {
    return 'NotificationModel{' +
        ' chuneImage: $chuneImage,' +
        ' userImage: $userImage,' +
        ' message: $message,' +
        ' type: $type,' +
        ' userId: $userId,' +
        ' chuneId: $chuneId,' +
        ' timeStamp: $timeStamp,' +
        '}';
  }

  NotificationModel copyWith({
    String chuneImage,
    String userImage,
    String message,
    String type,
    String userId,
    String chuneId,
    DateTime timeStamp,
  }) {
    return NotificationModel(
      chuneImage: chuneImage ?? this.chuneImage,
      userImage: userImage ?? this.userImage,
      message: message ?? this.message,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      chuneId: chuneId ?? this.chuneId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chuneImage': this.chuneImage,
      'userImage': this.userImage,
      'message': this.message,
      'type': this.type,
      'userId': this.userId,
      'chuneId': this.chuneId,
      'timeStamp': this.timeStamp,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      chuneImage: map['chune_image'] as String,
      userImage: map['user_image'] as String,
      message: map['message'] as String,
      type: map['type'] as String,
      userId: map['userId'] as String,
      chuneId: map['chuneId'] as String,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

//</editor-fold>
}