import 'package:icontech/core/utils/app_constants.dart';

import '../../main.dart';

class ApiService {


  ApiService();

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await dio.get(endPoint);
    return response.data;
  }

   Future<Map<String, dynamic>> post({required String endPoint, required Map<String, dynamic> data}) async {
    var response = await dio.post(endPoint, data: data);
    return response.data;
  }
}