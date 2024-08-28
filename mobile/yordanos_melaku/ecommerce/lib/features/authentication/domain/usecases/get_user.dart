import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserUsecase extends Usecase<UserEntity, NoParams> {
  AuthRepository authRepository;
  
  GetUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> execute(NoParams params) {
    return authRepository.getUser();
  }
}
