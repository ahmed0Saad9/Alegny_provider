class Profile {
  Profile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passwordHash,
    required this.universityIDCard,
    required this.nationalIDCard,
    required this.isApproved,
    required this.isDeleted,
    required this.status,
    required this.createdAt,
  });
  late final int id;
  late final String fullName;
  late final String email;
  late final String passwordHash;
  late final String universityIDCard;
  late final String nationalIDCard;
  late final bool isApproved;
  late final bool isDeleted;
  late final String status;
  late final String createdAt;

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    passwordHash = json['passwordHash'];
    universityIDCard = json['universityIDCard'];
    nationalIDCard = json['nationalIDCard'];
    isApproved = json['isApproved'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    createdAt = json['createdAt'];
  }
}
