import 'dart:convert';

import 'package:flutter_task_6/core/error/exception.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_local_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getCachedProducts', () {
    final tProductModelList =
        (json.decode(fixture('product_cached.json')) as List)
            .map((jsonitem) => ProductModel.fromJson(jsonitem))
            .toList();
    test(
        'should return list of products from sharedPreferences when they are in cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('product_cached.json'));
      //act
      final result = await dataSource.getCachedProducts();
      //assert
      verify(mockSharedPreferences.getString('CACHED PRODUCTS'));
      expect(result, equals(tProductModelList));
    });

    test('should throw cache exception when there is no cached product', () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getCachedProducts;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('getCachedProductById', () {
    final tProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));
    final tId = '1';
    test(
        'should return a specific product from sharedPreferences when it is in cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('product.json'));
      //act
      final result = await dataSource.getCachedProductById(tId);
      //assert
      verify(mockSharedPreferences.getString('CACHED PRODUCT ${tId}'));
      expect(result, equals(tProductModel));
    });

    test('should throw cache exception when there is no cached product', () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getCachedProducts;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('cacheProduct', () {
    final tProductModel = ProductModel(
        id: '1',
        name: 'Product 1',
        price: 100.0,
        description: 'Description of Product 1',
        imageUrl: 'url_to_image_1');

    test('should call sharedpreferences to cache the data', () {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      dataSource.cachProduct(tProductModel);
      //act
      final expectedJsonString = json.encode(tProductModel.toJson());
      //assert
      verify(mockSharedPreferences.setString(
          'CACHED PRODUCT', expectedJsonString));
    });
  });

  group('cacheProducts', () {
    final tProductModelList = [
      ProductModel(
          id: '1',
          name: 'Product 1',
          price: 100.0,
          description: 'Description of Product 1',
          imageUrl: 'url_to_image_1'),
      ProductModel(
          id: '2',
          name: 'Product 2',
          price: 200.0,
          description: 'Description of Product 2',
          imageUrl: 'url_to_image_2')
    ];

    test('should call sharedpreferences to cache the data', () {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      dataSource.cachProducts(tProductModelList);
      //act
      final expectedJsonString = json.encode(
          tProductModelList.map((product) => product.toJson()).toList());
      //assert
      verify(mockSharedPreferences.setString(
          'CACHED PRODUCTS', expectedJsonString));
    });
  });
}
