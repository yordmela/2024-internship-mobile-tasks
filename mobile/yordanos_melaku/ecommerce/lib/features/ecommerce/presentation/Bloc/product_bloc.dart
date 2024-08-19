import 'package:bloc/bloc.dart';

import '../../../../core/usecase.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/insert_product.dart';
import '../../domain/usecases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getAllProducts;
  final GetProductById getSingleProduct;
  final InsertProduct insertProduct;
  final DeleteProduct deleteProduct;
  final UpdateProduct updateProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getSingleProduct,
    required this.insertProduct,
    required this.deleteProduct,
    required this.updateProduct,
  }) : super(IntialState()) {
    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getAllProducts.execute(NoParams());
      result.fold(
        (failure) => emit(ErrorState(message: 'Error')),
        (products) => emit(LoadedAllProductState(products: products)),
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getSingleProduct.execute(event.productId);
      result.fold((failure) => emit(ErrorState(message: 'Error')),
          (product) => emit(LoadedSingleProductState(product:product)));
    });

    on<InsertProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await insertProduct.execute(event.product);
      result.fold((failure) => emit(ErrorState(message: 'Error')),
          (product) => emit(InsertedProductState(product:product)));
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await updateProduct.execute(event.product);
      result.fold((failure) => emit(ErrorState(message: 'Error')),
          (product) => emit(UpdatedProductState(product:product)));
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await deleteProduct.execute(event.productId);
      result.fold((failure) => emit(ErrorState(message: 'Error')),
          (product) => emit(DeletedProductState()));
    });
  }
}
