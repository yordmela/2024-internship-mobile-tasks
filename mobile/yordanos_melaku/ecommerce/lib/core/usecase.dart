import 'package:dartz/dartz.dart';

import 'error/failures.dart';

abstract class Usecase<Type,Params>{
  Future <Either<Failure, Type>> execute(Params params);
}

class NoParams  {}