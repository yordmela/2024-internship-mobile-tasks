import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required String id,
      required String name,
      required double price,
      required String description,
      required String imageUrl})
      : super(
            id: id,
            name: name,
            price: price,
            description: description,
            imageUrl: imageUrl);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        price: (json['price'] as num).toDouble(),
        description: json['description'],
        imageUrl: json['imageUrl']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl
    };
  }
  Product toProduct() {
  return Product(
    id: id,
    name: name,
    price: price,
    description: description,
    imageUrl: imageUrl,
  );
}
}
