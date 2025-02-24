import 'package:cattendanceapp/constants.dart';
import 'package:dio/dio.dart';

class AttendanceSaveService {
  AttendanceSaveService(this.dio);
  Dio dio;

  Future<Response> saveAttendance(String token, String q, String workerId,
      String areaId, String lat, String long) async {
    const String url = '$kAppUrlApi/attendance/apiSaveAttendance';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Response response = await dio.post(url, data: {
        "key": kAppKey,
        "q": q,
        "worker_id": workerId,
        "area_id": areaId,
        "lat": lat,
        "longt": long
      });
      print(response.data['message']);

      return response;
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
