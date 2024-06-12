import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../config/APIs/apis_urls.dart';
import '../../../../config/constants/app_strings.dart';
import '../../../../storage.dart';

class DioHelper {
  static late Dio dio;

  static init()  {
    dio = Dio(
      BaseOptions(
        baseUrl: ApisStrings.baseUrl,
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json,
      ),
    );
    // dio.options.headers = {
    //   "Accept": "application/json",
    //   "Authorization":
    //   "Bearer ${AppSharedPreferences.getString(key: AppStrings.accessToken)}"
    // };
    Future<String?>? refreshToken() async {
      try {
        final refreshToken = AppSharedPreferences.getString(key: AppStrings.refreshToken);
        final response = await dio.get(ApisStrings.refreshTokenUrl, queryParameters: {'token': refreshToken});
        final newAccessToken = response.data['access_token'];
        AppSharedPreferences.setString(value: newAccessToken, key: AppStrings.accessToken);
        return newAccessToken ;
      } catch (e) {
       // AppSharedPreferences.sharedPreferences.remove(AppStrings.accessToken);
        AppSharedPreferences.sharedPreferences.clear();

      }
      return null;
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers = {
            "Accept": "application/json",
            "Authorization":
                "Bearer ${AppSharedPreferences.getString(key: AppStrings.accessToken)}"
          };
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final newAccessToken = await refreshToken();
            if (newAccessToken != null) {
              dio.options.headers = {
                "Authorization": "Bearer $newAccessToken)"
              };
              return handler.resolve(await dio.fetch(error.requestOptions));
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // static setOptions(accessToken) async {
  //   dio.options.headers = {
  //     "Accept": "application/json",
  //     "Authorization":
  //         "Bearer ${AppSharedPreferences.getString(key: AppStrings.accessToken)}"
  //   };
  // }
}
