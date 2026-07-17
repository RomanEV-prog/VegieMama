import 'package:dio/dio.dart';

/// Shared HTTP client for future backend calls.
/// The base URL is empty until a real backend exists.
class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._();

  static const String baseUrl = ''; // TODO: real backend URL

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
}
