import 'package:http/http.dart' as http;

import 'package:flutter_task_6/core/network/network_info.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_local_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([ProductRepository,ProductLocalDataSource,ProductRemoteDataSource,NetworkInfo, InternetConnectionChecker,SharedPreferences,http.Client])

void main(){}

