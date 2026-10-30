import 'package:dio/dio.dart';
import 'package:more_devs_do_zero/shared/http_exceptions.dart';

class HttpClient {
  HttpClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api-production-c0289.up.railway.app/api/v1',
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              sendTimeout: const Duration(seconds: 15),
              headers: const {
                'accept': 'application/json',
                'content-type': 'application/json',
              },
            ),
          );

  final Dio _dio;

  Future<Object?> post(String path, {Object? data}) async {
    try {
      final response = await _dio.post<Object?>(path, data: data);
      return response.data;
    } on DioException catch (error) {
      throw HttpClientException(
        message: error.message ?? 'Falha ao comunicar com o servidor.',
        statusCode: error.response?.statusCode,
        responseData: error.response?.data,
      );
    }
  }
}