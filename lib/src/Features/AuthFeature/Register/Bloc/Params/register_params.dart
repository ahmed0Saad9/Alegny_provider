import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:Alegny_provider/src/Features/AuthFeature/EditGeneralProfile/Bloc/Controller/edit_general_profile_controller.dart';

enum GenderType {
  male,
  female,
}

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String nationalId;
  final String idOfCollege;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.nationalId,
    required this.idOfCollege,
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
      'fullName': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'nationalIDCard': nationalId,
      'universityIDCard': idOfCollege,
      'device_key': 'token',
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
