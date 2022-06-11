final String tableNotification = 'notification';

class NotificationFields {
  static final List<String> values = [
    /// Add all fields
    id, msgTitle, msgBody, time
  ];

  static final String id = '_id';
  static final String msgTitle = 'messageTitle';
  static final String msgBody = 'messageBody';
  static final String time = 'time';
}

class Notifications {
  final int? id;
  final String title;
  final String body;
  final DateTime createdTime;

  const Notifications({
    this.id,
    required this.title,
    required this.body,
    required this.createdTime,
  });

  Notifications copy({
    int? id,
    String? title,
    String? body,
    DateTime? createdTime,
  }) =>
      Notifications(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdTime: createdTime ?? this.createdTime,
      );

  static Notifications fromJson(Map<String, Object?> json) => Notifications(
        id: json[NotificationFields.id] as int?,
        title: json[NotificationFields.msgTitle] as String,
        body: json[NotificationFields.msgBody] as String,
        createdTime: DateTime.parse(json[NotificationFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NotificationFields.id: id,
        NotificationFields.msgTitle: title,
        NotificationFields.msgBody: body,
        NotificationFields.time: createdTime.toIso8601String(),
      };
}
