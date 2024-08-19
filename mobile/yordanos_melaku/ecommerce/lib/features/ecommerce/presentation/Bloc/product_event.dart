import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';

@immutable
abstract class ProductEvent extends Equatable{
  ProductEvent();
  List <Object> get props=> [];
}

class LoadAllProductEvent extends ProductEvent{

}
class GetSingleProductEvent extends ProductEvent{
  final String productId;
  GetSingleProductEvent(this.productId);

  @override
  List <Object> get props =>[productId];
}

class UpdateProductEvent extends ProductEvent{
  final Product product;
  UpdateProductEvent(this.product);

  @override
  List <Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent{
  final String productId;
 DeleteProductEvent(this.productId);
 
  @override
  List <Object> get props =>[productId];
}

class InsertProductEvent extends ProductEvent{
  final Product product;
  InsertProductEvent(this.product);

  @override
  List <Object> get props => [product];
}