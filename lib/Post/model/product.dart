class Product {
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? images;

  Product(
      {this.title, this.price, this.description, this.categoryId, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    categoryId = json['categoryId'];
    images = List<String>.from(json['images'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'categoryId': categoryId,
      'images': images,
    };
  }
}
