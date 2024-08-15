import 'package:flutter_task_6/core/platform/network_info.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_local_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProductRepository,ProductLocalDataSource,ProductRemoteDataSource,NetworkInfo])

void main(){}

