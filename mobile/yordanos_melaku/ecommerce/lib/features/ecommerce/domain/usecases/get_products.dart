import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class GetProducts extends BaseUsecase<List <Product>, NoParams>{
  final ProductRepository repository;

  GetProducts(this.repository);

  Future <Either<Failure, List<Product>>> execute(NoParams params) {
    return repository.getProducts();
  }

}

class NoParams {
}