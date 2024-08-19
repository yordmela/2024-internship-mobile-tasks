import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/ecommerce/data/datasources/product_local_data_source.dart';
import 'features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'features/ecommerce/data/repositories/product_repository_impl.dart';
import 'features/ecommerce/domain/repositories/product_repository.dart';
import 'features/ecommerce/domain/usecases/delete_product.dart';
import 'features/ecommerce/domain/usecases/get_products.dart';
import 'features/ecommerce/domain/usecases/insert_product.dart';
import 'features/ecommerce/domain/usecases/update_product.dart';
import 'features/ecommerce/presentation/Bloc/product_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //feature

  // bloc
  sl.registerFactory(() => ProductBloc(
      getAllProducts: sl(),
      getSingleProduct: sl(),
      insertProduct: sl(),
      deleteProduct: sl(),
      updateProduct: sl()));

  //usecase
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => InsertProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));

  //core
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //datasource
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
