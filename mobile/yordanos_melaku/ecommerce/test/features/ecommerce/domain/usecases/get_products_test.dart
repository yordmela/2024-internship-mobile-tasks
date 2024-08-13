
import 'package:dartz/dartz.dart';
import 'package:flutter_task_6/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/get_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.mocks.dart';


// class MockProductRepository extends Mock
//   implements ProductRepository{}

void main(){
  late GetProducts usecase;
  late MockProductRepository mockProductRepository;

  setUp((){
    mockProductRepository= MockProductRepository();
    usecase= GetProducts(mockProductRepository);
  });

  final tProductList=[
const Product(image:'this' , name: 'Sneaker', catagory: 'mens shoes', price: 100, rating: 5.0, description: 'this is sneaker', size: [32,37,87]),
const Product(image:'this' , name: 'Sneaker', catagory: 'mens shoes', price: 100, rating: 5.0, description: 'this is sneaker', size: [32,37,87])

  ];



  test('should get product from repo', ()async{

    

when(mockProductRepository.getProducts())
    .thenAnswer((_) async => Right(tProductList));

final result= await usecase.execute(NoParams ());


expect(result, Right(tProductList));
verify(mockProductRepository.getProducts());
verifyNoMoreInteractions(mockProductRepository);
  });
}