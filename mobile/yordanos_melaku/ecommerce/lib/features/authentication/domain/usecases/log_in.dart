import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/login_entity.dart';
import '../entities/token_entity.dart';
import '../repositories/auth_repository.dart';

class LogInUsecase extends Usecase<TokenEntity, LoginParam> {
  final AuthRepository authRepository;

  LogInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, TokenEntity>> execute(LoginParam loginParam) {
    return authRepository.login(loginParam.loginEntity);
  }
}

class LoginParam extends Equatable {
  final LoginEntity loginEntity;
  const LoginParam({required this.loginEntity});

  List<Object> get props => [loginEntity];
}
