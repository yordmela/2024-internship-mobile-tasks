import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_task_6/core/error/failures.dart';
import 'package:flutter_task_6/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_task_6/features/ecommerce/presentation/Bloc/product_bloc.dart';
import 'package:flutter_task_6/features/ecommerce/presentation/Bloc/product_event.dart';
import 'package:flutter_task_6/features/ecommerce/presentation/Bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.mocks.dart';

void main() {
  late ProductBloc productBloc;
  late MockGetProducts mockGetProducts;
  late MockGetProductById mockGetProductById;
  late MockInsertProduct mockInsertProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockUpdateProduct mockUpdateProduct;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockGetProductById = MockGetProductById();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockInsertProduct = MockInsertProduct();

    productBloc = ProductBloc(
        getAllProducts: mockGetProducts,
        getSingleProduct: mockGetProductById,
        insertProduct: mockInsertProduct,
        deleteProduct: mockDeleteProduct,
        updateProduct: mockUpdateProduct);
  });

  Product product = const Product(
    id: '1',
    name: 'jeans',
    price: 100,
    description: 'this is jeans',
    imageUrl: '../assets/bag.jpg',
  );
  String tId = '1';

  test('initial state should be initial state', () {
    //assert
    expect(productBloc.state, IntialState());
  });

  group('LoadAllProductEvent', () {
    List<Product> productList = [
      const Product(
        id: '1',
        name: 'jeans',
        price: 100,
        description: 'this is jeans',
        imageUrl: '../assets/bag.jpg',
      ),
      const Product(
        id: '1',
        name: 'jeans',
        price: 100,
        description: 'this is jeans',
        imageUrl: '../assets/bag.jpg',
      )
    ];

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when LoadAllProductEvent is added and getAllProducts returns data',
      build: () {
        when(mockGetProducts.execute(any))
            .thenAnswer((_) async => Right(productList));

        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        LoadingState(),
        LoadedAllProductState(products: productList),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when LoadAllProductEvent is unsuccessful',
      build: () {
        when(mockGetProducts.execute(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when LoadAllProductEvent is unsuccessful',
      build: () {
        when(mockGetProducts.execute(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );
  });

  group('GetSingleProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadSingleProductState] when GetSingleProductEvent is added and getSingleProduct returns data',
      build: () {
        when(mockGetProductById.execute(any))
            .thenAnswer((_) async => Right(product));

        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tId)),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(product: product),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when GetSingleProductEvent is unsuccessful',
      build: () {
        when(mockGetProductById.execute(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tId)),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when getSingleProductEvent is unsuccessful',
      build: () {
        when(mockGetProductById.execute(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tId)),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );
  });

  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, UpdatedProductState] when UpdateProductEvent is added and updateProduct updates product',
      build: () {
        when(mockUpdateProduct.execute(any))
            .thenAnswer((_) async => Right(product));

        return productBloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [
        LoadingState(),
        UpdatedProductState(product: product),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when UpdateProductEvent is unsuccessful',
      build: () {
        when(mockUpdateProduct.execute(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(product)),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );
  });

  group('InsertProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, InsertedProductState] when InsertProductEvent is added and insertProduct insert product',
      build: () {
        when(mockInsertProduct.execute(any))
            .thenAnswer((_) async => Right(product));

        return productBloc;
      },
      act: (bloc) => bloc.add(InsertProductEvent(product)),
      expect: () => [
        LoadingState(),
        InsertedProductState(product: product),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when InsertProductEvent is unsuccessful',
      build: () {
        when(mockInsertProduct.execute(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(InsertProductEvent(product)),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );
  });

  group('DeleteProductEvent', () {

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, DeletedProductState] when DeleteProductEvent is added and deleteProduct delete product',
      build: () {
        when(mockDeleteProduct.execute(any))
            .thenAnswer((_) async => Right(product));

        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tId)),
      expect: () => [
        LoadingState(),
        DeletedProductState(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when DeleteProductEvent is unsuccessful',
      build: () {
        when(mockDeleteProduct.execute(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tId)),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );

   
  });
}
