import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProducts();
        localDataSource.cachProducts(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    if (await networkInfo.isConnected){
      try{
      final remoteProduct= await remoteDataSource.getProductById(id);
      localDataSource.cachProduct(remoteProduct);
      return Right(remoteProduct);} on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final localProducts= await localDataSource.getCachedProductById(id);
        return Right(localProducts);

      }on CacheException{
        return Left(CacheFailure());
      }
    }
   
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async{
    if (await networkInfo.isConnected){
      try{
        final updatedProduct= await remoteDataSource.updateProduct(product);
        return Right(updatedProduct);
      }
      on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async{
    if (await networkInfo.isConnected){
      try{
        final deletedProduct= await remoteDataSource.deleteProduct(id);
        return Right(deletedProduct);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> insertProduct(Product product) async{
    if(await networkInfo.isConnected){
      try{
        final insertedProduct= await remoteDataSource.insertProduct(product);
        return Right(insertedProduct);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(NetworkFailure());
    }
  }
}
