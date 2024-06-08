import 'package:dio/dio.dart';
import 'package:tasky/storage.dart';

abstract class ProfileRemoteDateSource {
  Future<Map<String, dynamic>> getProfileData();
}

class ProfileRemoteDateSourceImpl implements ProfileRemoteDateSource {
  final Dio dio;

  ProfileRemoteDateSourceImpl({required this.dio});
  @override
  Future<Map<String, dynamic>> getProfileData() async {
    var response = await dio.get(
      "https://todo.iraqsapp.com/auth/profile",
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${AppSharedPreferences.sharedPreferences.getString("accessToken")}',
        },
      ),
    );
    print(
        "this Token is AfterApi ${AppSharedPreferences.sharedPreferences.getString("accessToken")}}");
    if (response.statusCode == 200) {
      print("the Profile Data is ${response.data}");
      return response.data;
    } else {
      print("the status Code is ${response.data}");
      throw "Some thing is wrong";
    }
  }
}
