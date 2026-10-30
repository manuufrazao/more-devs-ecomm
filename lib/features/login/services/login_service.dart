import 'dart:io';

import 'package:dio/dio.dart';
import 'package:more_devs_do_zero/features/login/model/auth_user.dart';
import 'package:more_devs_do_zero/shared/http_client.dart';

class LoginService {
  final HttpClient httpClient = HttpClient();

  Future<LoginResponseModel> login({
    required String email,
    required String senha,
  }) async {
    try {
      final response = await httpClient.post(
        '/auth/login',
        data: {'email': email, 'password': senha},
      );

      return LoginResponseModel.fromJson(response as Map<String, dynamic>);
    } on DioException catch (e) {
      print('Erro ao fazer login: ${e.message}');
      rethrow;
    } on HttpException catch (e) {
      print('Erro HTTP: ${e.message}');
      rethrow;
    }
  }
}
