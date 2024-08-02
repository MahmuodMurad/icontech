import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import '../../features/login/presentation/screens/login_screen.dart';
import '../../main.dart';
import '../utils/app_ruters.dart';
import 'end_points.dart';

class AuthenticatorInterceptor extends Interceptor {
  AuthenticatorInterceptor(this.acsToken);
 String acsToken;
 String refToken = '';
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await storage.read(key: 'accessToken');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      options.headers['Authorization'] = 'Bearer $acsToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.read(key: 'refreshToken');
      if (refreshToken != null) {
        try {
          final response = await Dio().put(
            EndPoints.refreshForToken,
            data: {
              'refreshToken': refreshToken,
            },
          );
          final accessToken = response.data['accessToken'];
          await storage.write(key: 'accessToken', value: accessToken);
          err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

          Dio dio = Dio();
          dio.options.method = err.requestOptions.method;
          dio.options.headers = err.requestOptions.headers;
          var resp = await dio.request(err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters);
          handler.resolve(resp);
        } catch (e) {
          // Failed to refresh the token, log out the user
          await storage.deleteAll();
          AppRouters.router.pushReplacement(AppRouters.kLoginView);
        }
      } else if (refToken != '') {
        try {
          final response = await Dio().put(
            EndPoints.refreshForToken,
            data: {
              'refreshToken': refToken,
            },
          );
          acsToken = response.data['accessToken'];
          err.requestOptions.headers['Authorization'] = 'Bearer $acsToken';

          Dio dio = Dio();
          dio.options.method = err.requestOptions.method;
          dio.options.headers = err.requestOptions.headers;
          var resp = await dio.request(err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters);
          handler.resolve(resp);
        } catch (e) {
          // Failed to refresh the token, log out the user
          await storage.deleteAll();
          AppRouters.router.pushReplacement(AppRouters.kLoginView);
        }
      } else {
        // No refresh token found, log out the user
        await storage.deleteAll();
        AppRouters.router.pushReplacement(AppRouters.kLoginView);
      }
    } else {
      handler.next(err);
    }
    Future.value();
  }
}
