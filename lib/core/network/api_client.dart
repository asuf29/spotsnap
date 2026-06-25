import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../config/app_config.dart';

class ApiClient {
  ApiClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// GET JSON from remote API or bundled mock assets.
  Future<Map<String, dynamic>> getJson(String path) async {
    if (AppConfig.useRemoteApi) {
      final url = '${AppConfig.apiBaseUrl.replaceAll(RegExp(r'/+$'), '')}/$path';
      final response = await _dio.get<Map<String, dynamic>>(url);
      return response.data ?? {};
    }

    final assetPath = path.endsWith('.json') ? path : '$path.json';
    final raw = await rootBundle.loadString('assets/mock_api/$assetPath');
    return jsonDecode(raw) as Map<String, dynamic>;
  }
}
