mixin ApiKey {
  static const String apiBaseUrl =
      'https://alegny-provider.premiumasp.net/api/v1/';

  static const String account = 'account/';
  static const String providerAuth = 'provider-auth/';
  static const String general = 'General/';
  static const String student = 'Student/';

  /// Auth
  final String uRLSetting = "${apiBaseUrl}setting";
  final String uRLLogin = "$apiBaseUrl${providerAuth}login";
  final String uRLRegister = "$apiBaseUrl${providerAuth}register";
  final String uRLLogout = "$apiBaseUrl${providerAuth}logout";
  final String uRLChangePassword = "$apiBaseUrl${providerAuth}change-password";
  final String uRLGetMyAccountData = "$apiBaseUrl${account}my-account";
  final String uRLUpdateMyAccountData =
      "$apiBaseUrl${account}my-account/update";
  final String uRLVerifyAccount =
      "$apiBaseUrl${account}my-account/verify-account";
  final String uRLSendOTP = "$apiBaseUrl${account}send-verify-otp";
  final String uRLVerifyAccountOtp =
      "$apiBaseUrl${account}validate-otp-and-verify-account";
  // final String uRLCities = "$apiBaseUrl${public}cities";
  // final String uRLDistricts = "$apiBaseUrl${public}districts";

  final String uRLCheckPhoneAndSendOtp = "${apiBaseUrl}forgot-password";
  final String uRLValidateOtpAndChangePassword =
      "${apiBaseUrl}validate-otp-and-change-password";
  final String uRLGetMyNotifications =
      "$apiBaseUrl${account}my-account/notifications";

  final String uRLCheckQrCode = "$apiBaseUrl${account}qr-code-check";

  final String uRLNotifications = "$apiBaseUrl${account}notifications?=";

  String uRLProfile({required int universityIDCard}) =>
      "$apiBaseUrl${student}Profile/$universityIDCard";

  // app
  String uRLGetAllSubjects(
          {required int academicYear, required String search}) =>
      "$apiBaseUrl${general}subjects?academicYear=$academicYear&search=$search";

  String uRLGetChapters({required int? subjectID}) =>
      "${apiBaseUrl}upload/subjects/$subjectID/chapters";

  String uRLGetQuestions({required int? chaptersID}) =>
      "${apiBaseUrl}upload/chapters/$chaptersID/questions";

  String uRLUploadedPdfs({required String status, required int studentID}) =>
      "${apiBaseUrl}StudentQuiz/$student$studentID/pdfs?status=$status";
  String uRLGetCustomQuestions({required int fileId, required int studentId}) =>
      "${apiBaseUrl}StudentQuiz/student/$studentId/uploads/$fileId/quizzes";
  final String uRLUploadPdf = "${apiBaseUrl}UploadStudent/upload-pdf";
}
