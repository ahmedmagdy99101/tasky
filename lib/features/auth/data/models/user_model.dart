import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String phoneNumber,
    required String token,
  }) : super(id: id, phoneNumber: phoneNumber, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
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
