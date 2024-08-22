import 'dart:convert';

import 'package:flutter_task_6/core/error/exception.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  void setUpMockHttpClientSuccess200(fixtureval) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture(fixtureval), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });
  final tProductModelList = (json.decode(fixture('product_cached.json'))['data'] as List)
      .map((jsonItem) => ProductModel.fromJson(jsonItem))
      .toList();

  final tProductModel =
      ProductModel.fromJson(json.decode(fixture('product.json')));
  final uri=Uri.parse(
              'https://g5-flutter-learning-path-be.onrender.com/api/v1/products');

  final tId = '1';
  group('getProducts', () {
    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      //arrange
      setUpMockHttpClientSuccess200('product_cached.json');
      //act
      dataSource.getProducts();
      //assert
      verify(mockHttpClient.get(uri,
          headers: {'Content-Type': 'application/json'}));
    });

    test(
        'should return list of Products when the response code is 200 (success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200('product_cached.json');
      //act
      final result = await dataSource.getProducts();
      //assert
      expect(result, equals(tProductModelList));
    });

    test('should throw server exception when the response code is 404',
        () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getProducts;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getProduct', () {
    
    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      //arrange
      setUpMockHttpClientSuccess200('product.json');
      //act
      dataSource.getProductById(tId);
      //assert
      verify(mockHttpClient.get(
          Uri.parse(
              'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return product when the response code is 200 (success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200('product.json');
      //act
      final result = await dataSource.getProductById(tId);
      //assert
      expect(result, equals(tProductModel));
    });
    test('should throw server exception when the response code is 404',
        () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getProductById;
      //assert
      expect(() => call(tId), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('updateProduct', () {
  
  final tProductModel = ProductModel(
    id: '1',
    name: 'jeans',
    price: 100,
    description: 'this is jeans',
    imageUrl: '../assets/bag.jpg',
  );

  test(
      'should preform a PUT request on a URL with number being the endpoint and with application/json header',
      () {
    //arrange
    when(mockHttpClient.put(
  any,
  headers: anyNamed('headers'),
  body: anyNamed('body')
)).thenAnswer((_) async => http.Response(json.encode({'data': tProductModel.toJson()}), 200));


    
    //act
    dataSource.updateProduct(tProductModel);
    //assert
    verify(mockHttpClient.put(
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/${tId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tProductModel.toJson()),
    ));
  });

  test('should return updated product when the response code is 200 (success)',
      () async {
    //arrange
when(mockHttpClient.put(
  any,
  headers: anyNamed('headers'),
  body: anyNamed('body')
)).thenAnswer((_) async => http.Response(json.encode({'data': tProductModel.toJson()}), 200));

    //act
    final result = await dataSource.updateProduct(tProductModel);
    //assert
    expect(result, equals(tProductModel));
  });

  test('should throw ServerException when the response code is 404 or other failure',
      () async {
    //arrange
    when(mockHttpClient.put(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Something went wrong', 404));
    //act
    final call = dataSource.updateProduct;
    //assert
    expect(() => call(tProductModel), throwsA(const TypeMatcher<ServerException>()));
  });
});

group('deleteProduct', () {


  test('should perform a DELETE request on a URL with the id being the endpoint', () async {
    // Arrange
    when(mockHttpClient.delete(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response(json.encode({'data': tProductModel.toJson()}), 200));

    // Act
    await dataSource.deleteProduct(tId);

    // Assert
    verify(mockHttpClient.delete(
      Uri.parse('https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$tId'),
      headers: {'Content-Type': 'application/json'},
    ));
  });

  test('should throw ServerException when the response code is not 200', () async {
    // Arrange
    when(mockHttpClient.delete(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response('Something went wrong', 404));

    // Act
    final call = dataSource.deleteProduct;

    // Assert
    expect(() => call(tId), throwsA(const TypeMatcher<ServerException>()));
  });
});

 group('insertProduct', () {
    test(
      'should perform a POST request on a URL with the product and return the created product when the response code is 201 (success)',
      () async {
        // Arrange
        final mockStreamedResponse = http.StreamedResponse(
          Stream.fromIterable([
            utf8.encode(json.encode({'data': tProductModel.toJson()}))
          ]),
          201,
        );

        when(mockHttpClient.send(any)).thenAnswer((_) async => mockStreamedResponse);

        // Act
        final result = await dataSource.insertProduct(tProductModel);

        // Assert
        expect(result, equals(tProductModel));
      },
    );

    test(
      'should throw ServerException when the response code is not 201',
      () async {
        // Arrange
        final mockStreamedResponse = http.StreamedResponse(
          Stream.fromIterable([utf8.encode('Something went wrong')]),
          400,
        );

        when(mockHttpClient.send(any)).thenAnswer((_) async => mockStreamedResponse);

        // Act
        final call = dataSource.insertProduct;

        // Assert
        expect(() => call(tProductModel), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

}
