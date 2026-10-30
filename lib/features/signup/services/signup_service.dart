import 'dart:io';
import 'package:dio/dio.dart';
import 'package:more_devs_do_zero/shared/http_client.dart';

class SignupService {
  HttpClient httpClient = HttpClient();

  Future<void> signUp({
    required String name,
    required String email,
    required String senha,
    required String confirmarSenha,
    required bool termosDeUso,
  }) async {
    try {
      await httpClient.post(
        '/auth/register',
        data: {
          "name": name,
          "email": email,
          "password": senha,
          "confirmPassword": confirmarSenha,
          "acceptedTerms": termosDeUso,
        },
      );
    } on DioException catch (e) {
      print('Erro ao cadastrar: ${e.message}');
      rethrow;
    } on HttpException catch (e) {
      print('Erro HTTP: ${e.message}');
      rethrow;
    }
  }
}