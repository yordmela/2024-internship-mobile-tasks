import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/signup_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUsecase extends Usecase<UserEntity, SignUpParam> {
  AuthRepository authRepository;
  SignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> execute(SignUpParam signupParam) {
    return authRepository.signUp(signupParam.signupEntity);
  }
}

class SignUpParam extends Equatable {
  final SignupEntity signupEntity;
  SignUpParam({required this.signupEntity});
  @override
  List<Object> get props => [signupEntity];
}
