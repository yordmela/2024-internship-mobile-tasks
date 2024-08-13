
import 'package:dartz/dartz.dart';
import 'package:flutter_task_6/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';


// class MockProductRepository extends Mock
//   implements ProductRepository{}

void main(){
  late DeleteProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository= MockProductRepository();
    usecase= DeleteProduct(mockProductRepository);
  });


int tProductId= 1;
 final tProduct= Product(image:'this' , name: 'Sneaker', catagory: 'mens shoes', price: 100, rating: 5.0, description: 'this is sneaker', size: [32,37,87]);
  test('should get product from repo', ()async{

    

when(mockProductRepository.deleteProduct(tProductId))
    .thenAnswer((_) async => Right(tProduct));

final result= await usecase.execute(tProductId);


expect(result, Right(tProduct));
verify(mockProductRepository.deleteProduct(tProductId));
verifyNoMoreInteractions(mockProductRepository);
  });
}