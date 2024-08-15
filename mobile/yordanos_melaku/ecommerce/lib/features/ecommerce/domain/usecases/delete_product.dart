
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase.dart';

class DeleteProduct extends Usecase <void, String>{
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future <Either<Failure, void>> execute(id) {
    return repository.deleteProduct(id);
  }

}
