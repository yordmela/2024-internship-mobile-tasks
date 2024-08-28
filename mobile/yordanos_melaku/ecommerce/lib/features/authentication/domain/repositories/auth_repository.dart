import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../entities/signup_entity.dart';
import '../entities/token_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future <Either<Failure, TokenEntity>> login(LoginEntity loginEntity);
  Future <Either<Failure, UserEntity>> signUp(SignupEntity signupEntity);
  Future <Either<Failure, UserEntity>> getUser();
  // Future <Either<Failure, UserEntity>> logout();
}