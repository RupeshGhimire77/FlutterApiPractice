import 'package:intern_practice/Get/api.dart';
import 'package:intern_practice/Get/api_const.dart';
import 'package:intern_practice/Get/api_service.dart';
import 'package:intern_practice/Post/core/api_response.dart';

class ApiServiceImpl extends ApiService {
  Api api = Api();
  @override
  Future<ApiResponse> getData() async {
    ApiResponse apiResponse = await api.getApi(getUrl);
    return apiResponse;
  }
}
