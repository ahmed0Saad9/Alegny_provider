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
  final String uRLResetPassword = "$apiBaseUrl${providerAuth}reset-password";
  final String uRLForgetPassword = "$apiBaseUrl${providerAuth}forgot-password";
  final String uRLGetMyAccountData = "$apiBaseUrl${providerAuth}profile";
  final String uRLUpdateMyAccountData = "$apiBaseUrl${providerAuth}profile";
  final String uRLVerifyAccount =
      "$apiBaseUrl${account}my-account/verify-account";
  final String uRLSendOTP = "$apiBaseUrl${account}send-verify-otp";
  final String uRLVerifyAccountOtp =
      "$apiBaseUrl${account}validate-otp-and-verify-account";

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

  final String uRLAddService = "${apiBaseUrl}services";
  final String uRLGetServices = "${apiBaseUrl}services/";
  String uRLDeleteService({required String serviceId}) =>
      "${apiBaseUrl}services/$serviceId";
  String uRLEditService({required String serviceId}) =>
      "${apiBaseUrl}services/$serviceId";
  String uRLGetServiceDetailsService({required String serviceId}) =>
      "${apiBaseUrl}services/$serviceId";
  String uRLUpdateServiceService({required String serviceId}) =>
      "${apiBaseUrl}services/$serviceId";
}
