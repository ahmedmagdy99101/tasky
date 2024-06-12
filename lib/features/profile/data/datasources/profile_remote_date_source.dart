import 'package:dio/dio.dart';
import 'package:tasky/config/APIs/apis_urls.dart';
import 'package:tasky/storage.dart';

import '../../../../core/utils/services/remote/dio_helper.dart';

abstract class ProfileRemoteDateSource {
  Future<Map<String, dynamic>> getProfileData();
}

class ProfileRemoteDateSourceImpl implements ProfileRemoteDateSource {


  ProfileRemoteDateSourceImpl();
  @override
  Future<Map<String, dynamic>> getProfileData() async {
    var response = await DioHelper.dio.get(
      ApisStrings.profileUrl,
      // options: Options(
      //   headers: {
      //     'Authorization':
      //         'Bearer ${AppSharedPreferences.sharedPreferences.getString("accessToken")}',
      //   },
      // ),
    );
    print(
        "this Token is AfterApi ${AppSharedPreferences.sharedPreferences.getString("accessToken")}}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("the Profile Data is ${response.data}");
      return response.data;
    } else {
      print("the status Code is ${response.data}");
      throw "Some thing is wrong";
    }
  }
}
