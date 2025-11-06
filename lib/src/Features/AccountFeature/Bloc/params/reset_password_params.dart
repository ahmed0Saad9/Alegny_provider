class ResetPasswordParams {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toMap() => {
        "oldPassword": currentPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      };
}
