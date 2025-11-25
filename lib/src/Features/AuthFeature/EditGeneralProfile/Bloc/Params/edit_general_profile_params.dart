import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:path/path.dart' as path;

class EditProfileParam {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final MediaType? image;

  EditProfileParam({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.image,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    // Add text fields
    formData.fields.add(MapEntry('firstName', firstName));
    formData.fields.add(MapEntry('lastName', lastName));
    formData.fields.add(MapEntry('email', email));
    formData.fields.add(MapEntry('phoneNumber', phoneNumber));

    // Add image file if exists
    if (image != null) {
      // Get the file extension from the path
      String fileName = image!.media.path.split('/').last;
      String fileExtension = fileName.split('.').last.toLowerCase();

      // Determine the MIME type
      String mimeType = 'image/png'; // default
      if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
        mimeType = 'image/jpeg';
      } else if (fileExtension == 'gif') {
        mimeType = 'image/gif';
      }

      print('=== FILE UPLOAD DETAILS ===');
      print('File path: ${image!.media.path}');
      print('File name: $fileName');
      print('File extension: $fileExtension');
      print('MIME type: $mimeType');

      try {
        // Create multipart file - use http_parser.MediaType
        final multipartFile = await MultipartFile.fromFile(
          image!.media.path,
          filename: fileName,
          contentType: http_parser.MediaType.parse(mimeType),
        );

        formData.files.add(MapEntry('profileImage', multipartFile));
        print('Multipart file created successfully');
      } catch (e) {
        print('Error creating multipart file: $e');
      }
    } else {
      print('No image to upload');
    }

    return formData;
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}

// "nationalityId": 25715549,
// "firstNameEn": "adipisicing",
// "lastNameEn": "minim ullamco",
// "familyNameEn": "nisi do",
// "qId": "ullamco Lorem labore",
// "genderId": 41742021,
// "email": "consectetur ipsum Lorem velit",
// "mobile": "eu",
// "address": "eius",
// "username": "aute id commo",
// "birthDate": "2016-09-26T08:12:26.159Z",
// "passport": "in",
// "userPassword": "aute adipisicing et"
