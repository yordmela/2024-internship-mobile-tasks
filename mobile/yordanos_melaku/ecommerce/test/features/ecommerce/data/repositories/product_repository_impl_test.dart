import 'package:dartz/dartz.dart';
import 'package:flutter_task_6/core/error/exception.dart';
import 'package:flutter_task_6/core/error/failures.dart';
import 'package:flutter_task_6/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_task_6/features/ecommerce/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  final tProductModelList = [
    ProductModel(
        id: '1',
        name: 'this',
        price: 100,
        description: 'this is this',
        imageUrl: '../assets/bag.jpg'),
    ProductModel(
        id: '1',
        name: 'this',
        price: 100,
        description: 'this is this',
        imageUrl: '../assets/bag.jpg')
  ];

  final tProductModel=ProductModel(
        id: '1',
        name: 'this',
        price: 100,
        description: 'this is this',
        imageUrl: '../assets/bag.jpg');
  final tId= '1';

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
       body();
    });

   
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });

    
  }

  group('getProducts', () {
    runTestOnline(() {
      test(
        'should return remote data when the call to the remote data is successful',
        () async {
//arrange
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => tProductModelList);
//act
      final result = await repository.getProducts();

      //assert
      verify(mockRemoteDataSource.getProducts());
      expect(result, Right(tProductModelList));
    });

    test(
        'should cache the data locally when the call to the remote datasource is successful',
        () async {
//arrange
      when(mockRemoteDataSource.getProducts())
          .thenAnswer((_) async => tProductModelList);
//act
      await repository.getProducts();

      //assert
      verify(mockRemoteDataSource.getProducts());
      verify(mockLocalDataSource.cachProducts(tProductModelList));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.getProducts()).thenThrow(ServerException());
      //act
      final result = await repository.getProducts();
      //assert
      verify(mockRemoteDataSource.getProducts());
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    });

    runTestOffline(() {
      test('should return the last cached data when the cached data is available',
        () async {
      //arrange
      when(mockLocalDataSource.getCachedProducts())
          .thenAnswer((_) async => tProductModelList);
      //act
      final result = await repository.getProducts();
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getCachedProducts());
      expect(result, equals(Right(tProductModelList)));
    });
    test('should return cache failure when there is no cache data', () async {
      //arrange
      when(mockLocalDataSource.getCachedProducts()).thenThrow(CacheException());
      //act
      final result = await repository.getProducts();
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getCachedProducts());
      expect(result, Left(CacheFailure()));
    });
    });
  });

group('getProductById', () {
    runTestOnline(() {
      test(
        'should return remote data when the call to the remote data is successful',
        () async {
//arrange
      when(mockRemoteDataSource.getProductById(tId))
          .thenAnswer((_) async => tProductModel);
//act
      final result = await repository.getProductById(tId);

      //assert
      verify(mockRemoteDataSource.getProductById(tId));
      expect(result, Right(tProductModel));
    });

    test(
        'should cache the data locally when the call to the remote datasource is successful',
        () async {
//arrange
      when(mockRemoteDataSource.getProductById(tId))
          .thenAnswer((_) async => tProductModel);
//act
      await repository.getProductById(tId);

      //assert
      verify(mockRemoteDataSource.getProductById(tId));
      verify(mockLocalDataSource.cachProduct(tProductModel));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.getProductById(tId)).thenThrow(ServerException());
      //act
      final result = await repository.getProductById(tId);
      //assert
      verify(mockRemoteDataSource.getProductById(tId));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    });

    runTestOffline(() {
      test('should return the last cached data when the cached data is available',
        () async {
      //arrange
      when(mockLocalDataSource.getCachedProductById(tId))
          .thenAnswer((_) async => tProductModel);
      //act
      final result = await repository.getProductById(tId);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getCachedProductById(tId));
      expect(result, equals(Right(tProductModel)));
    });
    test('should return cache failure when there is no cache data', () async {
      //arrange
      when(mockLocalDataSource.getCachedProductById(tId)).thenThrow(CacheException());
      //act
      final result = await repository.getProductById(tId);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getCachedProductById(tId));
      expect(result, Left(CacheFailure()));
    });
    });
  });



  group('updateProduct', () {
    runTestOnline(() {
      test(
        'should update a specific product on the remote data when the call to the remote data is successful',
        () async {
//arrange
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => tProductModel);
//act
      final result = await repository.updateProduct(tProductModel);

      //assert
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      expect(result, Right(tProductModel));
    });

    

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.updateProduct(tProductModel)).thenThrow(ServerException());
      //act
      final result = await repository.updateProduct(tProductModel);
      //assert
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    });

    runTestOffline(() {
     
    test('should return network failure when there is no connection to the remote data source', () async {
      //arrange
      when(mockRemoteDataSource.updateProduct(tProductModel)).thenThrow(CacheException());
      //act
      final result = await repository.updateProduct(tProductModel);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(NetworkFailure()));
    });
    });
  });

  group('deleteProduct', () {
    runTestOnline(() {
      test(
        'should delete a specific product on the remote data when the call to the remote data is successful',
        () async {
//arrange
      when(mockRemoteDataSource.deleteProduct(tId))
          .thenAnswer((_) async => null );
//act
      final result = await repository.deleteProduct(tId);

      //assert
      verify(mockRemoteDataSource.deleteProduct(tId));
      expect(result, const Right(null));
    });

    

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.deleteProduct(tId)).thenThrow(ServerException());
      //act
      final result = await repository.deleteProduct(tId);
      //assert
      verify(mockRemoteDataSource.deleteProduct(tId));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    });

    runTestOffline(() {
     
    test('should return network failure when there is no connection to the remote data source', () async {
      //arrange
      when(mockRemoteDataSource.deleteProduct(tId)).thenThrow(CacheException());
      //act
      final result = await repository.deleteProduct(tId);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(NetworkFailure()));
    });
    });
  });

   group('insertProduct', () {
    runTestOnline(() {
      test(
        'should insert the product on the remote data when the call to the remote data is successful',
        () async {
//arrange
      when(mockRemoteDataSource.insertProduct(tProductModel))
          .thenAnswer((_) async => tProductModel);
//act
      final result = await repository.insertProduct(tProductModel);

      //assert
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      expect(result, Right(tProductModel));
    });

    

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRemoteDataSource.insertProduct(tProductModel)).thenThrow(ServerException());
      //act
      final result = await repository.insertProduct(tProductModel);
      //assert
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
    });

    runTestOffline(() {
     
    test('should return network failure when there is no connection to the remote data source', () async {
      //arrange
      when(mockRemoteDataSource.insertProduct(tProductModel)).thenThrow(CacheException());
      //act
      final result = await repository.insertProduct(tProductModel);
      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, Left(NetworkFailure()));
    });
    });
  });
}