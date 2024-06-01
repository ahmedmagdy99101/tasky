import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phoneNumber;
  final String token;

  User({
    required this.id,
    required this.phoneNumber,
    required this.token,
  });

  @override
  List<Object> get props => [id, phoneNumber, token];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
    );
  }
}
