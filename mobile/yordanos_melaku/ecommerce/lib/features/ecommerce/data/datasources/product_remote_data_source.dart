import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
    Future<List <ProductModel>> getProducts();
    Future <ProductModel> getProductById(String id);
    Future <ProductModel> updateProduct(Product product);
    Future <void> deleteProduct(String id);
    Future <ProductModel> insertProduct(Product product);

}