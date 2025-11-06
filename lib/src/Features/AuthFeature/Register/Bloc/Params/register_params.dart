import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';

enum GenderType {
  male,
  female,
}

class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<Map<String, dynamic>> toMap() async {
    String? token = '';
    // try {
    //   token = await _fcm.getToken();
    //   printDM("device_key is => $token");
    // } catch (e) {
    //   printDM('an error occur in fetch token');
    // }
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  // Future<FormData> toFormData() async {
  //   FormData formMap = FormData.fromMap(await toMap());
  //   if (image != null) {
  //     formMap.files.add(
  //       MapEntry(
  //         'image',
  //         await MultipartFile.fromFile(
  //           image!.media.path,
  //           filename: path.basename(image!.media.path),
  //         ),
  //       ),
  //     );
  //   }
  //   return formMap;
  // }
}
