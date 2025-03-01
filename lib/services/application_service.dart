import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/application_model.dart';
import 'package:dio/dio.dart';

class ApplicationService {
  Dio dio;

  ApplicationService(this.dio);
  String url = '$kAppUrlApi/applications';
  Future<List<ApplicationModel>?> getApplications(String token) async {
    const String url = '$kAppUrlApi/applications';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final Response response = await dio.get(url);
      final data = response.data;

      if (response.data['message'] == 'No record available') {
        return null;
      }

      final list = response.data['data'] as List;
      final List<ApplicationModel> applicationsList = [];

      for (int i = 0; i < list.length; i++) {
        ApplicationModel applicationModel = ApplicationModel.fromJson(data, i);
        applicationsList.add(applicationModel);
      }

      return applicationsList;
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> sendApplication(
      Map<String, dynamic> dataApplication, String token) async {
    const String url = '$kAppUrlApi/applications';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final Response response = await dio.post(url, data: dataApplication);
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
