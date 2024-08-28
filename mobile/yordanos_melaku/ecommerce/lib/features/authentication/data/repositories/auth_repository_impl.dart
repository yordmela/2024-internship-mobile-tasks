import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/signup_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  NetworkInfo networkInfo;
  AuthLocalDataSource localDataSource;
  AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, TokenEntity>> login(LoginEntity loginEntity) async {
    if (await networkInfo.isConnected) {

      try {
        final result = await remoteDataSource.login(loginEntity as LoginModel);
        localDataSource.cacheUserToken(result.token);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }on CacheException{
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(SignupEntity signupEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.signup(signupEntity as SignupModel);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }on CacheException{
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final token = await localDataSource.getCachedUserToken();
        final result = await remoteDataSource.getuser(token!);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException{
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
