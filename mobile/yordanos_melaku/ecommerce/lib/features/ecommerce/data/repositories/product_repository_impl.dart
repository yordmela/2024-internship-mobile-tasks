import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository{
    final ProductRemoteDataSource remoteDataSource;
    final ProductLocalDataSource localDataSource;
    final NetworkInfo networkInfo;

    ProductRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

    @override
  Future<Either<Failure, List<Product>>> getProducts() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) {
    throw UnimplementedError();
  }
}
