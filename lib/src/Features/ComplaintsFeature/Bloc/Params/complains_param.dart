// lib/src/Features/ComplaintsFeature/Bloc/Params/complaint_params.dart
import 'dart:io';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

class ComplaintParams extends Equatable {
  final String subject;
  final String message;
  final File? complaintImage;

  const ComplaintParams({
    required this.subject,
    required this.message,
    this.complaintImage,
  });

  // Convert to JSON string for complaintDataJson
  String _toJsonString() {
    return jsonEncode({
      'Subject': subject,
      'Message': message,
    });
  }

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'complaintDataJson': _toJsonString(),
    });

    if (complaintImage != null) {
      formData.files.add(MapEntry(
        'complaintImage',
        await MultipartFile.fromFile(
          complaintImage!.path,
          filename: complaintImage!.path.split('/').last,
        ),
      ));
    }

    return formData;
  }

  Map<String, dynamic> toMap() {
    return {
      'complaintDataJson': _toJsonString(),
    };
  }

  @override
  List<Object?> get props => [subject, message, complaintImage];
}
