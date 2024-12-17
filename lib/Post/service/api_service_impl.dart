import 'package:intern_practice/Post/core/api.dart';
import 'package:intern_practice/Post/core/api_const.dart';
import 'package:intern_practice/Post/core/api_response.dart';
import 'package:intern_practice/Post/model/product.dart';
import 'package:intern_practice/Post/service/api_service.dart';

class ApiServiceImpl extends ApiService {
  Api api = Api();

  @override
  Future<ApiResponse> postData(Product product) async {
    ApiResponse response = await api.postApi(
      postUrl,
      product.toJson(),
    );
    print("Request Data: ${product.toJson()}");
    print("Response: ${response.data}");

    return response;
  }
}
