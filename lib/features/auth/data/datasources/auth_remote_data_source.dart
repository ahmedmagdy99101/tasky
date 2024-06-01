import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String phoneNumber, String password);
  Future<void> register(String phoneNumber, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> login(String phoneNumber, String password) async {
    final response = await dio.post(
      'https://your-api-url.com/auth/login',
      data: {'phoneNumber': phoneNumber, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> register(String phoneNumber, String password) async {
    // Make your HTTP request to register the user
    // You would typically use dio.post() or a similar method
    // Example:
    // await dio.post('/register', data: {'phoneNumber': phoneNumber, 'password': password});
  }

}
