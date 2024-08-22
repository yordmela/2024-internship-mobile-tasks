import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';

@immutable
abstract class ProductState extends Equatable {
  ProductState();
  List<Object> get props => [];
}

class IntialState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedAllProductState extends ProductState {
  final List<Product> products;
  LoadedAllProductState({required this.products}
  );
  

  @override
  List<Object> get props=>[products];
}

class LoadedSingleProductState extends ProductState {
  final Product product;
  LoadedSingleProductState({required this.product});

  @override
  List<Object> get props=> [product];
}

class InsertedProductState extends ProductState{
  final Product product;
  InsertedProductState({required this.product});
  @override
  List<Object> get props=> [product];
}

class UpdatedProductState extends ProductState{
  final Product product;
  UpdatedProductState({required this.product});
  @override
  List<Object> get props=> [product];
}

class DeletedProductState extends ProductState{}

class ErrorState extends ProductState {
  final String message;
  ErrorState({required this.message});

  @override
  List <Object> get props=> [message];
}
