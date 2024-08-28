import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

class UserLoadFailure extends AuthState {
  final String message;
  UserLoadFailure({required this.message});
}

class UserLoaded extends AuthState {
  final UserEntity user;
  const UserLoaded({required this.user});
}
