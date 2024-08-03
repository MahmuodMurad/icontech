import '../../main.dart';

class ApiService {
  ApiService();

  Future<Map<String, dynamic>> get({required String endPoint, Map<String, dynamic>? queryParameters}) async {
    var response = await dio.get(endPoint, queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String, dynamic>> post({required String endPoint, required Map<String, dynamic> data}) async {
    var response = await dio.post(endPoint, data: data);
    return response.data;
  }
}
