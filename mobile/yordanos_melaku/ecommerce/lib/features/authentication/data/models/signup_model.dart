import '../../domain/entities/signup_entity.dart';

class SignupModel extends SignupEntity{
  SignupModel({required super.name, required super.email, required super.password});

  factory SignupModel.fromJson(Map<String,dynamic> json){
      return SignupModel(name: json['name'], email: json['email'], password: json['password']);
  }

  Map<String,dynamic> toJson(){
   return {
    'name':name,
    'email': email,
    'password':password
   };
  }
}