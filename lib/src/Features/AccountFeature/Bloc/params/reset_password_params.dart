class ResetPasswordParams {
  final String universityIDCard;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;

  ResetPasswordParams({
    required this.universityIDCard,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  Map<String, dynamic> toMap() => {
        "UniversityIDCard": universityIDCard,
        "CurrentPassword": currentPassword,
        "NewPassword": newPassword,
        "ConfirmNewPassword": confirmNewPassword,
      };
}
