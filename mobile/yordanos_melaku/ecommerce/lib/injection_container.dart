import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/datasources/auth_local_data_source.dart';
import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/get_user.dart';
import 'features/authentication/domain/usecases/log_in.dart';
import 'features/authentication/domain/usecases/sign_up.dart';
import 'features/authentication/presentation/Bloc/auth_bloc.dart';
import 'features/ecommerce/data/datasources/product_local_data_source.dart';
import 'features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'features/ecommerce/data/repositories/product_repository_impl.dart';
import 'features/ecommerce/domain/repositories/product_repository.dart';
import 'features/ecommerce/domain/usecases/delete_product.dart';
import 'features/ecommerce/domain/usecases/get_product_by_id.dart';
import 'features/ecommerce/domain/usecases/get_products.dart';
import 'features/ecommerce/domain/usecases/insert_product.dart';
import 'features/ecommerce/domain/usecases/update_product.dart';
import 'features/ecommerce/presentation/Bloc/product_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies (should only be registered once)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Core (Common for all features)
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<InternetConnectionChecker>()));

  // Product feature
  // Use Cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => InsertProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerFactory(() => GetProductById(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  // Bloc
  sl.registerFactory(() => ProductBloc(
      getAllProducts: sl(),
      getSingleProduct: sl(),
      insertProduct: sl(),
      deleteProduct: sl(),
      updateProduct: sl()));

  // Auth feature
  // Use Cases
  sl.registerLazySingleton(() => GetUserUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => LogInUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(authRepository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
      getUserUsecase: sl(),
      logInUsecase: sl(),
      signUpUsecase: sl()));
}























// final sl = GetIt.instance;
// Future<void> init() async {
//   //feature

//   // bloc
//   sl.registerFactory(() => ProductBloc(
//       getAllProducts: sl(),
//       getSingleProduct: sl(),
//       insertProduct: sl(),
//       deleteProduct: sl(),
//       updateProduct: sl()));

//   //usecase
//   sl.registerLazySingleton(() => GetProducts(sl()));
//   sl.registerLazySingleton(() => UpdateProduct(sl()));
//   sl.registerLazySingleton(() => InsertProduct(sl()));
//   sl.registerLazySingleton(() => DeleteProduct(sl()));
//   sl.registerFactory(()=> GetProductById(sl()));

//   //core
//   sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

//   //datasource
//   sl.registerLazySingleton<ProductLocalDataSource>(
//       () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
//   sl.registerLazySingleton<ProductRemoteDataSource>(
//       () => ProductRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoImpl(sl<InternetConnectionChecker>()));

//   //external
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());


  







//   sl.registerFactory(() => AuthBloc(
//       getUserUsecase: sl(),
//       logInUsecase: sl(),
//       signUpUsecase: sl(),));

//   //usecase
//   sl.registerLazySingleton(() => GetUserUsecase(authRepository: sl()));
//   sl.registerLazySingleton(() => LogInUsecase(authRepository: sl()));
//   sl.registerLazySingleton(() => SignUpUsecase(authRepository: sl()));

//   //core
//   sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

//   //datasource
//   sl.registerLazySingleton<AuthLocalDataSource>(
//       () => AuthLocalDataSourceImpl(sharedPreferences: sl()));
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoImpl(sl<InternetConnectionChecker>()));

//   //external
//   // final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
// }
