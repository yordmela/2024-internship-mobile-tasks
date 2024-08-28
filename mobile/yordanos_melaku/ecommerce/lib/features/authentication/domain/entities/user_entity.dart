import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  

  UserEntity({required this.id,required this.name, required this.email});

  List <Object> get props => ([name, email]);
}