import 'package:dio/dio.dart';
import 'package:intern_practice/Post/core/api_response.dart';
import 'package:intern_practice/Post/core/helper.dart';
import 'package:intern_practice/Post/core/status_util.dart';
import 'package:intern_practice/Post/core/string_const.dart';

class Api {
  Dio dio = Dio();

  Future<ApiResponse> postApi(String url, var jsonData) async {
    if (await Helper.checkInternet()) {
      try {
        Response response = await dio.post(url, data: jsonData);

        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse(
              statusUtil: StatusUtil.success, data: response.data);
        }
      } catch (e) {
        print(e);
        return ApiResponse(
            statusUtil: StatusUtil.error, errorMessage: e.toString());
      }
    } else {
      return ApiResponse(
          statusUtil: StatusUtil.error, errorMessage: noInternetConnectionStr);
    }
    return ApiResponse(
        statusUtil: StatusUtil.error, errorMessage: "Unknown error");
  }
}
