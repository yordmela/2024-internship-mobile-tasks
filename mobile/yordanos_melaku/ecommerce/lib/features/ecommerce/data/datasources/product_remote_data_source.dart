import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Access the 'data' field, which contains the list of products
      final List<dynamic> responseList = jsonResponse['data'];

      // Map the list of products to ProductModel
      final List<ProductModel> productList = responseList
          .map((responseItem) => ProductModel.fromJson(responseItem))
          .toList();

      return productList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
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

    final productId = product.id;
    final response = await client.put(
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products/${productId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(Product product) async {
   
    final request= http.MultipartRequest('POST', Uri.parse(
          'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),);
    request.fields['name']= product.name;
    request.fields['description']= product.description;
    request.fields['price']= product.price.toString();
    if (product.imageUrl.isNotEmpty && File(product.imageUrl).existsSync()){
      request.files.add(await http.MultipartFile.fromPath('image', product.imageUrl, contentType: MediaType('image', 'jpeg')));
    }
    final response = await request.send();
    if (response.statusCode == 201) {
      var reponseBody= await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(reponseBody)['data']);
    } else {
      throw ServerException();
    }
  }
}
