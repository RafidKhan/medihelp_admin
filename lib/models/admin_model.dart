class AdminModel {
  String? userId;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;

  AdminModel({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.profilePicture,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
      };
}
