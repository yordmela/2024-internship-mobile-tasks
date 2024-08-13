
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase.dart';

class DeleteProduct extends Usecase <Product, int>{
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future <Either<Failure, Product>> execute(id) {
    return repository.deleteProduct(id);
  }

}
