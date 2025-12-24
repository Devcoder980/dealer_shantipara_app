import 'package:dio/dio.dart';
import '../core/api_endpoints.dart';
import '../core/dio_client.dart';
import '../models/commission.dart';

/// Commission service
class CommissionService {
  static final Dio _dio = DioClient.instance;

  /// Get commission summary for a specific month
  static Future<CommissionSummary> getSummary({
    required int year,
    required int month,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.commissionSummary(year: year, month: month),
      );
      return CommissionSummary.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to get commission summary');
    }
  }

  /// Get current month commission summary
  static Future<CommissionSummary> getCurrentMonthSummary() async {
    final now = DateTime.now();
    return getSummary(year: now.year, month: now.month);
  }

  /// Get last month commission summary
  static Future<CommissionSummary> getLastMonthSummary() async {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1);
    return getSummary(year: lastMonth.year, month: lastMonth.month);
  }
}
