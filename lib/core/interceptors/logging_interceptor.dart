import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor to log API requests and responses (only in debug mode)
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('╔══════════════════════════════════════════════════════════');
      debugPrint('║ REQUEST');
      debugPrint('╠══════════════════════════════════════════════════════════');
      debugPrint('║ URL: ${options.method} ${options.uri}');
      debugPrint('║ Headers: ${_prettyJson(options.headers)}');
      if (options.data != null) {
        debugPrint('║ Body: ${_prettyJson(options.data)}');
      }
      if (options.queryParameters.isNotEmpty) {
        debugPrint('║ Query: ${_prettyJson(options.queryParameters)}');
      }
      debugPrint('╚══════════════════════════════════════════════════════════');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('╔══════════════════════════════════════════════════════════');
      debugPrint('║ RESPONSE');
      debugPrint('╠══════════════════════════════════════════════════════════');
      debugPrint('║ URL: ${response.requestOptions.uri}');
      debugPrint('║ Status: ${response.statusCode}');
      debugPrint('║ Data: ${_prettyJson(response.data)}');
      debugPrint('╚══════════════════════════════════════════════════════════');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('╔══════════════════════════════════════════════════════════');
      debugPrint('║ ERROR');
      debugPrint('╠══════════════════════════════════════════════════════════');
      debugPrint('║ URL: ${err.requestOptions.uri}');
      debugPrint('║ Error Type: ${err.type}');
      debugPrint('║ Message: ${err.message}');
      if (err.response != null) {
        debugPrint('║ Status: ${err.response?.statusCode}');
        debugPrint('║ Response: ${_prettyJson(err.response?.data)}');
      }
      debugPrint('╚══════════════════════════════════════════════════════════');
    }
    handler.next(err);
  }

  /// Format JSON for pretty printing
  String _prettyJson(dynamic data) {
    try {
      if (data == null) return 'null';
      if (data is String) return data;
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }
}
