import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable{
  final String token;

  TokenEntity({required this.token});

  List <Object> get props=>([token]);
}