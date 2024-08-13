import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class GetProductById extends BaseUsecase<Product, int> {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> execute(id) {
    return repository.getProductById(id);
  }
}
