import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/usecase.dart';

class InsertProduct extends Usecase <Product, Product>{
  final ProductRepository repository;
  InsertProduct(this.repository);

  Future <Either<Failure, Product>> execute(Product product){
    return repository.insertProduct(product);
  }

}