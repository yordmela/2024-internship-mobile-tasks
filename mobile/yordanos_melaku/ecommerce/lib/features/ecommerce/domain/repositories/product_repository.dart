import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, Product>> deleteProduct(int id);
  Future<Either<Failure, Product>> insertProduct(Product product);
}
