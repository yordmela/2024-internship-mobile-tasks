import 'package:flutter_task_6/core/platform/network_info.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_local_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource{}
class MockLocalDataSource extends Mock implements ProductLocalDataSource{}
class MockNetworkInfo extends Mock implements NetworkInfo{}

void main(){
  ProductRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
      mockLocalDataSource= MockLocalDataSource();
      mockRemoteDataSource= MockRemoteDataSource();
      mockNetworkInfo= MockNetworkInfo();
      repository= ProductRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo
      );
  });

 
}