import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signup(SignupModel signup_model);
  Future<TokenModel> login(LoginModel login_model);
  Future<UserModel> getuser(String token);
  // Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  final BASE_URL =
      'https://g5-flutter-learning-path-be.onrender.com/api/v2';

  @override
  Future <UserModel> signup(SignupModel signupModel) async{
    
    final response= await client.post(
      Uri.parse('${BASE_URL}/auth/register'),
      headers: {'Content-Type': 'application/json'} ,
      body: json.encode(signupModel.toJson())
      ).timeout(const Duration(seconds: 10));

    if (response.statusCode==201){
      return UserModel.fromJson(json.decode(response.body)['data']);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<TokenModel> login(LoginModel login_model) async{
     final response= await client.post(
      Uri.parse('${BASE_URL}/auth/login'),
      headers: {'Content-Type': 'application/json'} ,
      body: json.encode(login_model.toJson())
     );
     if(response.statusCode==201){
      return TokenModel.fromJson(json.decode(response.body)['data']);
     }else{
      throw ServerException();
     }
  }
  

  @override
  Future<UserModel> getuser(String token) async{
    final response= await client.get(Uri.parse('${BASE_URL}/users/me'),
    headers: {'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
    } ,
    );

    if (response.statusCode==200){
      return UserModel.fromJson(json.decode(response.body)['data']);
    }else{
      throw ServerException();
    }

  }
}
