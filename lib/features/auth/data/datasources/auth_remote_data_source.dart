import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/config/APIs/apis_urls.dart';
import 'package:tasky/config/constants/app_strings.dart';
import 'package:tasky/storage.dart';

import '../../../../core/utils/services/remote/dio_helper.dart';

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


  AuthRemoteDataSourceImpl();

  @override
  Future<Map<String, dynamic>> login(String phoneNumber, String password) async {

 //  print(response.data);
    try {
      final response = await DioHelper.dio.post(
        ApisStrings.loginUrl,
        data: {"phone": phoneNumber, "password": password},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
     //   print({response.data});
        await AppSharedPreferences.setString( key: AppStrings.accessToken, value: response.data["access_token"] ,);
        await AppSharedPreferences.setString( key: AppStrings.refreshToken, value: response.data["refresh_token"] ,);
        await AppSharedPreferences.setString( key: "userID", value: response.data["_id"],);
        debugPrint("access Token is${AppSharedPreferences.getString(key: AppStrings.accessToken)}");
        debugPrint("refresh Token is${AppSharedPreferences.getString(key: AppStrings.refreshToken)}");
        return response.data;
      } else {
        debugPrint("${response.data.runtimeType}");
        return response.data;
      }
    } catch (e) {
      //AppSharedPreferences.sharedPreferences.setString("accessToken", response.data["access_token"]);
      debugPrint("this Exception is ${e.toString()} ");
      if(e is DioException){
        return e.response?.data;
      }
      return {};
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
    try {
      final response = await DioHelper.dio.post(
        ApisStrings.registerUrl,
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
      if (response.statusCode == 201 || response.statusCode == 200) {
        await AppSharedPreferences.setString( key: AppStrings.accessToken, value: response.data["access_token"] ,);
        await AppSharedPreferences.setString( key: AppStrings.refreshToken, value: response.data["refresh_token"] ,);
        await AppSharedPreferences.setString( key: "userID", value: response.data["_id"],);
        debugPrint("access Token is${AppSharedPreferences.getString(key: AppStrings.accessToken)}");
        debugPrint("refresh Token is${AppSharedPreferences.getString(key: AppStrings.refreshToken)}");
        debugPrint("${response.data}");
        return response.data;
      } else {
        debugPrint("${response.data}");
        return response.data;
      }
    } catch (e){
      if(e is DioException){
        return e.response?.data;
      }
      return {};
    }
    }

}
