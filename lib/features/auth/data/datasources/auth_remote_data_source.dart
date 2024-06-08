import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/storage.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String phoneNumber, String password);
  Future<Map<String, dynamic>> register({
    required String phoneNumber,
    required String password,
    required String displayName,
    int? experienceYears,
    String? level,
    String? address,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> login(
      String phoneNumber, String password) async {
    final response = await dio.post(
      'https://todo.iraqsapp.com/auth/login',
      data: {"phone": phoneNumber, "password": password},
    );

    try {
      if (response.statusCode == 201) {
        debugPrint(response.data);
        await AppSharedPreferences.sharedPreferences
            .setString("accessToken", response.data["access_token"]);
        debugPrint(
            "acsse Token is${AppSharedPreferences.sharedPreferences.getString("accessToken")}");
        return response.data;
      } else {
        debugPrint("${response.data.runtimeType}");
        return response.data;
      }
    } catch (e) {
      AppSharedPreferences.sharedPreferences
          .setString("accessToken", response.data["access_token"]);
      debugPrint("this Exception is ${e.toString()}  ${response.data.runtimeType}");
      return response.data;
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String phoneNumber,
    required String password,
    required String displayName,
    int? experienceYears,
    String? level,
    String? address,
  }) async {
    final response = await dio.post(
      'https://todo.iraqsapp.com/auth/register',
      data: {
        "phone": phoneNumber,
        "password": password,
        "displayName": displayName,
        "experienceYears": experienceYears,
        "address": address,
        "level": level //fresh , junior , midLevel , senior
      },
    );
    debugPrint("${response.statusCode}");
    if (response.statusCode == 201) {
      debugPrint("${response.data}");
      return response.data;
    } else {
      debugPrint("${response.data}");
      return response.data;
    }
  }
}
