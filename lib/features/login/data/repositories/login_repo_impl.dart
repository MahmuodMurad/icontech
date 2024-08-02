import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../main.dart';
import 'login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final ApiService apiService;

  LoginRepoImpl(this.apiService);

  String errorMessage = '';

  @override
  Future<Either<Failure, String>> login({
    required String phone,
    required String password,
    required int companyId,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: EndPoints.login,
        data: {
          'phone': phone,
          'password': password,
          'company_id': companyId,
        },
      );
      debugPrint('Response Status: ${response['status']}');
      debugPrint('Response Data: ${response.toString()}');

      final accessToken = response['access_token'];
      await storage.write(key: 'accessToken', value: accessToken);

      return right(response['msg']);
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('DioError Status Code: ${e.response!.statusCode}');
        debugPrint('DioError Data: ${e.response!.data}');
        if (e.response!.statusCode == 422 && e.response!.data['data']['validation_errors'] != null) {
          final validationErrors = e.response!.data['data']['validation_errors'] as Map<String, dynamic>;
          final formattedErrors = validationErrors.map((key, value) => MapEntry(key, List<String>.from(value)));

          return left(ServerFailure(
            'Validation Errors',
            validationErrors: formattedErrors,
          ));
        } else {
          errorMessage = e.response!.data['msg'] ?? 'Unknown error';
          debugPrint('Error Message: $errorMessage');
          return left(ServerFailure(errorMessage));
        }
      } else {
        errorMessage = e.message ?? 'Unknown error';
        debugPrint('DioError: $e');
        return left(ServerFailure(errorMessage));
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return left(ServerFailure(e.toString()));
    }
  }
}


