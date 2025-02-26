import 'package:cattendanceapp/constants.dart';
import 'package:cattendanceapp/models/page_model.dart';
import 'package:dio/dio.dart';

class PageServices {
  Dio dio;

  PageServices(this.dio);

  Future<PageModel> getPages(String token, int pageId) async {
    const String url = '$kAppUrlApi/pages';
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };

    try {
      final Response response = await dio.get(url);
      PageModel pageModel = PageModel.fromJson(response.data, pageId);
      return pageModel;
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception('Something went wrong .. please try again later');
    }
  }
}
