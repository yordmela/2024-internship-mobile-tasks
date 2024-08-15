import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase.dart';

class GetProductById extends Usecase<Product, String> {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Either<Failure, Product>> execute(id) {
    return repository.getProductById(id);
  }
}
