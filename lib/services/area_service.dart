import 'package:cattendanceapp/constants.dart';
import 'package:dio/dio.dart';

class AreaService {
  Dio dio;

  AreaService(this.dio);

  Future<List<dynamic>?> getAreaList(String token) async {
    const String url = '$kAppUrlApi/area/index';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Response response = await dio.get(url);
      if (response.data['message'] == 'success') {
        return response.data['area'];
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}
