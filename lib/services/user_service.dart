import 'package:cattendanceapp/constants.dart';
import 'package:dio/dio.dart';

class UserService {
  Dio dio;
  UserService(this.dio);

  Future<Response> updateUser(
      Map<String, dynamic> updatedData, String token, int userId) async {
    final String url = '$kAppUrlApi/users/$userId';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    try {
      FormData formData = FormData.fromMap(updatedData);
      Response response = await dio.post(url, data: formData);
      return response;
    } on DioException catch (e) {
      print(updatedData); 
      throw Exception(e);
    } catch (e) {
      throw Exception('Something went wrong please try again later');
    }
  }
}
