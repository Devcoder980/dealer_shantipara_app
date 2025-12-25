import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../services/order_service.dart';

/// Order stats provider
final orderStatsProvider = FutureProvider.autoDispose<OrderStats>((ref) async {
  return OrderService.getStats();
});

/// Orders list provider with pagination
final ordersListProvider =
    FutureProvider.autoDispose.family<List<Order>, int>((ref, page) async {
  return OrderService.getOrders(page: page);
});

/// All orders provider (for initial load)
final allOrdersProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  return OrderService.getOrders(page: 1, limit: 10);
});

/// Order detail provider
final orderDetailProvider =
    FutureProvider.autoDispose.family<Order, String>((ref, soNumber) async {
  return OrderService.getOrderDetail(soNumber);
});

/// Selected order SO number
final selectedOrderProvider = StateProvider<String?>((ref) => null);

/// Order filter state
enum OrderFilter { all, pending, approved, dispatched }

final orderFilterProvider = StateProvider<OrderFilter>((ref) => OrderFilter.all);

/// Filtered orders
final filteredOrdersProvider = Provider.autoDispose<AsyncValue<List<Order>>>((ref) {
  final filter = ref.watch(orderFilterProvider);
  final ordersAsync = ref.watch(allOrdersProvider);

  return ordersAsync.whenData((orders) {
    switch (filter) {
      case OrderFilter.pending:
        return orders.where((o) => o.status == 'PENDING').toList();
      case OrderFilter.approved:
        return orders.where((o) => o.status == 'APPROVED').toList();
      case OrderFilter.dispatched:
        return orders.where((o) => o.status == 'DISPATCHED').toList();
      case OrderFilter.all:
      default:
        return orders;
    }
  });
});
