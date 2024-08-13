import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'base_usecase.dart';

class UpdateProduct extends BaseUsecase <Product, Product>{
  final ProductRepository repository;
  UpdateProduct(this.repository);

  Future <Either<Failure, Product>> execute(Product product){
    return repository.updateProduct(product);
  }

}