import 'package:flutter/material.dart';
import 'package:intern_practice/Post/core/api_response.dart';
import 'package:intern_practice/Post/core/status_util.dart';
import 'package:intern_practice/Post/model/product.dart';
import 'package:intern_practice/Post/service/api_service.dart';
import 'package:intern_practice/Post/service/api_service_impl.dart';

class ProductProvider extends ChangeNotifier {
  StatusUtil _postProductStatus = StatusUtil.none;
  StatusUtil get postProductStatus => _postProductStatus;

  ApiService apiService = ApiServiceImpl();

  String? errorMessage;
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? _images; // Update to List<String>?

  // List<String>? get images => _images;

  void setTitle(String value) {
    title = value;
  }

  void setDescription(String value) {
    description = value;
  }

  // void addImage(String url) {
  //   if (url.isNotEmpty) {
  //     _images!.add(url);
  //     notifyListeners(); // Notify listeners about the change
  //   }
  // }

  // void removeImage(int index) {
  //   if (index >= 0 && index < _images!.length) {
  //     _images!.removeAt(index);
  //     notifyListeners(); // Notify listeners about the change
  //   }
  // }

  void setPrice(String value) {
    int? parsedPrice = int.tryParse(value);
    if (parsedPrice != null && parsedPrice > 0) {
      price = parsedPrice; // Only set if it's a positive number
    } else {
      price = 0; // Default to 0 or handle the error gracefully
    }
  }

  void setCategoryId(String value) {
    int? parsedCategoryId = int.tryParse(value);
    if (parsedCategoryId != null && parsedCategoryId > 0) {
      categoryId = parsedCategoryId; // Only set if it's a positive number
    } else {
      categoryId = 0; // Default to 0 or handle the error gracefully
    }
  }

  void setPostProductStatus(StatusUtil statusUtil) {
    _postProductStatus = statusUtil;
    notifyListeners();
  }

  Future<void> postProductData() async {
    if (_postProductStatus != StatusUtil.loading) {
      setPostProductStatus(StatusUtil.loading);
    }

    // Ensure price and categoryId are set to valid defaults if null
    Product product = Product(
      title: title,
      price:
          price != null && price! > 0 ? price : 1, // Ensure price is positive
      description: description,
      images: _images ??
          ["https://i.imgur.com/QkIa5tT.jpeg"], // Default to at least one image
      categoryId: categoryId != null && categoryId! > 0
          ? categoryId
          : 1, // Ensure categoryId is valid
    );

    // Debugging: Print the product data before making the API call
    print("Posting Product: ${product.toJson()}");

    ApiResponse apiResponse = await apiService.postData(product);
    print("Category ID: ${categoryId}");
    print("Price: ${price}");
    print("Images: ${_images}");
    print("Title: ${title}");
    print("Description: ${description}");

    if (apiResponse.statusUtil == StatusUtil.success) {
      setPostProductStatus(StatusUtil.success);
    } else if (apiResponse.statusUtil == StatusUtil.error) {
      errorMessage = apiResponse.errorMessage;
      setPostProductStatus(StatusUtil.error);
    }
  }
}
