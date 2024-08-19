import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(String id);
  Future<ProductModel> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> insertProduct(Product product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(
      Uri.parse('https://documenter.getpostman.com/view/24515281/2sA3XPBgv5'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseList = json.decode(response.body);
      final List<ProductModel> productList = responseList
          .map((responseitem) => ProductModel.fromJson(responseitem))
          .toList();
      return productList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      Uri.parse('https://documenter.getpostman.com/view/24515281/2sA3XPBgv5'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('https://documenter.getpostman.com/view/24515281/2sA3XPBgv5'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse('https://yourapiurl.com/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(Product product) async {
    final response = await client.post(
      Uri.parse('https://yourapiurl.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
