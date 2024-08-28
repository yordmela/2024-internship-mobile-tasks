import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class AuthLocalDataSource {
  Future <String?> getCachedUserToken();
  Future <void> cacheUserToken(String token);
  Future <void> clearUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});

  final CACHED_USER_TOKEN= 'CACHED_USER_TOKEN';

  @override
  Future <String?> getCachedUserToken() async{
      final token= sharedPreferences.getString(CACHED_USER_TOKEN);
      if (token!=null){
        return token;
      }else{
        throw CacheException();
      }
  }

  @override
  Future <void> cacheUserToken(String token) async{
   await sharedPreferences.setString(CACHED_USER_TOKEN, token);
  }
  
  @override
  Future <void> clearUserData() async{
    await sharedPreferences.remove(CACHED_USER_TOKEN);
  }


}