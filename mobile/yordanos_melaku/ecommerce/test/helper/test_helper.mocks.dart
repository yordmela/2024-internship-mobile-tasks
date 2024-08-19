import 'package:flutter_task_6/core/network/network_info.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_local_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:flutter_task_6/features/ecommerce/domain/repositories/product_repository.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/delete_product.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/get_product_by_id.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/get_products.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/insert_product.dart';
import 'package:flutter_task_6/features/ecommerce/domain/usecases/update_product.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([ProductRepository,ProductLocalDataSource,ProductRemoteDataSource,NetworkInfo, InternetConnectionChecker,SharedPreferences,http.Client,GetProducts,GetProductById, UpdateProduct, DeleteProduct, InsertProduct])

void main(){}

