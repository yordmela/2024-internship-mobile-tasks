
import 'package:dartz/dartz.dart';
import 'package:flutter_task_6/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/get_product_by_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';


// class MockProductRepository extends Mock
//   implements ProductRepository{}

void main(){
  late GetProductById usecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository= MockProductRepository();
    usecase= GetProductById(mockProductRepository);
  });


int tProductId= 1;
 final tProduct= Product(id: 1, name: 'this', price: 100, description: 'this is this', imageUrl: '../s');
  test('should get product from repo', ()async{

    

when(mockProductRepository.getProductById(tProductId))
    .thenAnswer((_) async => Right(tProduct));

final result= await usecase.execute(tProductId);


expect(result, Right(tProduct));
verify(mockProductRepository.getProductById(tProductId));
verifyNoMoreInteractions(mockProductRepository);
  });
}