import 'dart:convert';

import 'package:flutter_task_6/features/ecommerce/data/models/product_model.dart';
import 'package:flutter_task_6/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tProduct = ProductModel(
      id: '1',
      name: 'jeans',
      price: 100,
      description: 'this is jeans',
      imageUrl: '../assets/bag.jpg');
  test('should be subclass of product entity', () async {
    expect(tProduct, isA<Product>());
  });

  group('fromjson', () {
    test('should return a valid model when the json number is int', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('product.json'));

      final result = ProductModel.fromJson(jsonMap);
      expect(result, tProduct);
    });
  });

  group('fromjson', () {
    test('should return a valid model when the json number is int', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('product_double.json'));

      final result = ProductModel.fromJson(jsonMap);
      expect(result, tProduct);
    });
  });

  group('tojson', () {
    test('should return a valid json', () {
      final result = tProduct.toJson();
      final expectedJsonMap = {
        'id': '1',
        'name': 'jeans',
        'price': 100.0,
        'description': 'this is jeans',
        'imageUrl': '../assets/bag.jpg'
      };
      expect(result, expectedJsonMap);
    });
  });
}
