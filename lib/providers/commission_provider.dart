import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/commission.dart';
import '../services/commission_service.dart';

/// Selected year/month for commission
final commissionYearProvider = StateProvider<int>((ref) => DateTime.now().year);
final commissionMonthProvider = StateProvider<int>((ref) => DateTime.now().month);

/// Commission summary provider
final commissionSummaryProvider =
    FutureProvider.autoDispose<CommissionSummary>((ref) async {
  final year = ref.watch(commissionYearProvider);
  final month = ref.watch(commissionMonthProvider);
  return CommissionService.getSummary(year: year, month: month);
});

/// Current month commission provider
final currentMonthCommissionProvider =
    FutureProvider.autoDispose<CommissionSummary>((ref) async {
  return CommissionService.getCurrentMonthSummary();
});

/// Commission data only (for quick access)
final commissionDataProvider =
    Provider.autoDispose<AsyncValue<CommissionData>>((ref) {
  return ref.watch(commissionSummaryProvider).whenData((data) => data.summary);
});

/// Commission orders provider
final commissionOrdersProvider =
    Provider.autoDispose<AsyncValue<List<CommissionOrder>>>((ref) {
  return ref.watch(commissionSummaryProvider).whenData((data) => data.orders);
});
