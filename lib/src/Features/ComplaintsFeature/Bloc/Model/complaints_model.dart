class ComplaintModel {
  final String complaintId;
  final String? imageUrl;
  final String message;

  ComplaintModel({
    required this.complaintId,
    required this.imageUrl,
    required this.message,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintId: json['complaintId'] ?? '',
      imageUrl: json['imageUrl'],
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'complaintId': complaintId,
      'imageUrl': imageUrl,
      'message': message,
    };
  }
}
