import '../../../../core/error/exception.dart';
import '../../domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({required super.token});

  factory TokenModel.fromJson(Map<String,dynamic> json){
    try{
      return TokenModel(token: json['access_token']);
    }catch(e){
      throw JsonParsingException();
    }
  }
}