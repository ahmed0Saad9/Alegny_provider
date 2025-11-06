class UserModel {
  UserModel({
    required this.isSuccess,
    required this.message,
    required this.token,
    required this.email,
    required this.roles,
    required this.profileId,
    this.errors,
  });
  late final bool isSuccess;
  late final String message;
  late final String token;
  late final String email;
  late final List<String> roles;
  late final String profileId;
  late final Null errors;
  UserModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    token = json['token'];
    email = json['email'];
    roles = List.castFrom<dynamic, String>(json['roles']);
    profileId = json['profileId'];
    errors = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isSuccess'] = isSuccess;
    _data['message'] = message;
    _data['token'] = token;
    _data['email'] = email;
    _data['roles'] = roles;
    _data['profileId'] = profileId;
    _data['errors'] = errors;
    return _data;
  }
}
