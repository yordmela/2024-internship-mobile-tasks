import 'package:equatable/equatable.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/signup_entity.dart';

abstract class AuthEvent extends Equatable{
  AuthEvent();

  @override
  List<Object> get props=>[];
}

class LoginEvent extends AuthEvent{
  final LoginEntity loginEntity;
  LoginEvent({required this.loginEntity});
}
class SignupEvent extends AuthEvent{
  final SignupEntity signupEntity;
  SignupEvent({required this.signupEntity});
}
class GetUserEvent extends AuthEvent{}

