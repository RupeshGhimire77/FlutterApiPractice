import 'package:intern_practice/Get/core/api.dart';
import 'package:intern_practice/Get/core/api_const.dart';
import 'package:intern_practice/Get/service/api_service.dart';
import 'package:intern_practice/Post/core/api_response.dart';

class ApiServiceImpl extends ApiService {
  Api api = Api();
  @override
  Future<ApiResponse> getData() async {
    ApiResponse apiResponse = await api.getApi(getUrl);
    return apiResponse;
  }
}
