

import 'package:flutter_task_6/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.mocks.dart';
void main(){
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp((){
      mockInternetConnectionChecker= MockInternetConnectionChecker();
      networkInfo= NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', (){
    test('should forward the call to DataConnectionChecker.isConnected', () async{
 //arrange
 final tHasConnectionFuture= Future.value(true);
 when(mockInternetConnectionChecker.hasConnection).thenAnswer((_)=>tHasConnectionFuture);
 //act
 final result= networkInfo.isConnected;
 //assert
 verify(mockInternetConnectionChecker.hasConnection);
 expect(result, tHasConnectionFuture);
    });
  });
  
}