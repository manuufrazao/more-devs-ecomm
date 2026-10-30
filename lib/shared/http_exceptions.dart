class HttpClientException implements Exception {
  final String message;
  final int? statusCode;
  final Object? responseData;

  const HttpClientException({
    required this.message,
    this.statusCode,
    this.responseData,
  });

  @override
  String toString() => message;
}