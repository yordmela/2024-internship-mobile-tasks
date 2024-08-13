import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class BaseUsecase<Type,Params>{
  Future <Either<Failure, Type>> execute(Params params);
}