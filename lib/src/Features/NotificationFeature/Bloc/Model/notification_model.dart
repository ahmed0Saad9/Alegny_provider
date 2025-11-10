class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime dateSent;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.dateSent,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      dateSent: DateTime.parse(json['dateSent'] ?? DateTime.now().toString()),
      isRead: json['isRead'] ?? false,
    );
  }

  NotificationModel copyWith({
    bool? isRead,
  }) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      dateSent: dateSent,
      isRead: isRead ?? this.isRead,
    );
  }
}
