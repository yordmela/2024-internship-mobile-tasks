import '../models/product_model.dart';

abstract class ProductLocalDataSource {
Future <List<ProductModel>> getCachedProducts();
Future <ProductModel> getCachedProductById(String id);
Future <void> cachProducts(List<ProductModel> productToCache);
Future <void> cachProduct(ProductModel productToCache);
}