import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.phoneNumber,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      phoneNumber: json["access_token"],
      token: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'phoneNumber': phoneNumber,
      'token': token,
    };
  }
}
