import 'package:cattendanceapp/constants.dart';
import 'package:dio/dio.dart';

class LoginService {
  Dio dio;

  LoginService(this.dio);

  Future<Response> login(String email, String password) async {
    const String url = '$kAppUrlApi/login';

    try {
      final Response response = await dio.post(url, data: {
        "email": email,
        "password": password,
      });
      return response;
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e); 
    }
  }
}
