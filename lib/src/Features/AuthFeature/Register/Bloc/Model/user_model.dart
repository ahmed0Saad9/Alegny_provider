// import 'package:Alegny/src/Features/AuthFeature/Register/Bloc/Model/nationality_model.dart';
//
// class BaseUserModel {
//   BaseUserModel({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final Data data;
//   late final String message;
//
//   BaseUserModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'] ?? false;
//     data = Data.fromJson(json['data']);
//     message = json['message'] ?? "-Error-";
//   }
// }
//
// class Data {
//   Data({
//     required this.user,
//     // required this.token,
//   });
//   late final UserModel user;
//   // late final String token;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     user = UserModel.fromJson(json['user']);
//     // token = json['token'] ?? '';
//   }
// }
//
// class UserModel {
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.verified,
//     // required this.image,
//   });
//   late final int id;
//   late final String name;
//   late final String email;
//   late final bool verified;
//   // late final String image;
//
//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'] ?? 0;
//     name = json['name'] ?? "";
//     email = json['email'] ?? "";
//     verified = json['verified'] ?? false;
//     // image = json['image'] ?? "";
//   }
// }
import 'dart:developer';

class UserModel {
  UserModel({
    required this.message,
    required this.student,
  });
  late final String message;
  late final Student student;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    student = Student.fromJson(json['student']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['student'] = student.toJson();
    return _data;
  }
}

class Student {
  Student({
    required this.id,
    required this.fullName,
    required this.email,
    required this.universityIDCard,
    required this.nationalIDCard,
    required this.isApproved,
    required this.isDeleted,
    required this.createdAt,
  });
  late final int id;
  late final String fullName;
  late final String email;
  late final String universityIDCard;
  late final String nationalIDCard;
  late final bool isApproved;
  late final bool isDeleted;
  late final String createdAt;

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    universityIDCard = json['universityIDCard'];
    nationalIDCard = json['nationalIDCard'];
    isApproved = json['isApproved'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['universityIDCard'] = universityIDCard;
    _data['nationalIDCard'] = nationalIDCard;
    _data['isApproved'] = isApproved;
    _data['isDeleted'] = isDeleted;
    _data['createdAt'] = createdAt;
    return _data;
  }
}
