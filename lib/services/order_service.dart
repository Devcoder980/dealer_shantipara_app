import 'package:dio/dio.dart';
import '../core/api_endpoints.dart';
import '../core/dio_client.dart';
import '../models/order.dart';

/// Order service
class OrderService {
  static final Dio _dio = DioClient.instance;

  /// Get order statistics
  static Future<OrderStats> getStats() async {
    try {
      final response = await _dio.get(ApiEndpoints.orderStats);
      return OrderStats.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to get order stats');
    }
  }

  /// Get paginated orders list
  static Future<List<Order>> getOrders({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.orders,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      return OrdersResponse.fromJson(response.data).orders;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to get orders');
    }
  }

  /// Get order detail by SO number
  static Future<Order> getOrderDetail(String soNumber) async {
    try {
      final response = await _dio.get(ApiEndpoints.orderDetail(soNumber));
      final data = response.data['data'] as Map<String, dynamic>;
      return Order.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to get order detail');
    }
  }
}
