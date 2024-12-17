import 'package:intern_practice/Post/core/api_response.dart';
import 'package:intern_practice/Post/model/product.dart';

abstract class ApiService {
  Future<ApiResponse> postData(Product product);
}
