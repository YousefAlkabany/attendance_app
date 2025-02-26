import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/application_model.dart';
import 'package:dio/dio.dart';

class ApplicationService {
  Dio dio;

  ApplicationService(this.dio);

  Future<List<ApplicationModel>> getApplications(String token) async {
    const String url = '$kAppUrlApi/applications';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final Response response = await dio.get(url);
      final data = response.data;
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
      throw Exception(e);
    }
  }
}
