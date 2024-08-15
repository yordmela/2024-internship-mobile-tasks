import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<ProductModel> getCachedProductById(String id);
  Future<void> cachProducts(List<ProductModel> productToCache);
  Future<void> cachProduct(ProductModel productToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  final CACHED_PRODUCT = 'CACHED PRODUCTS';

  ProductLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCT);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      final List<ProductModel> productList =
          jsonList.map((jsonitem) => ProductModel.fromJson(jsonitem)).toList();
      return Future.value(productList);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getCachedProductById(id) {
    final jsonString = sharedPreferences.getString('CACHED PRODUCT ${id}');
    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  Future<void> cachProducts(List<ProductModel> productToCache) {
    final jsonString =
        json.encode(productToCache.map((product) => product.toJson()).toList());
    return sharedPreferences.setString(CACHED_PRODUCT, jsonString);
  }

  @override
  Future<void> cachProduct(ProductModel productToCache) {
    return sharedPreferences.setString(
        'CACHED PRODUCT', json.encode(productToCache.toJson()));
  }
}
