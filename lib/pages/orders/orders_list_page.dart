import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/order_provider.dart';
import '../../routes/routers.dart';
import 'order_detail_page.dart';

/// Orders list page
class OrdersListPage extends ConsumerWidget {
  static const String routeName = '/orders';

  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(filteredOrdersProvider);
    final currentFilter = ref.watch(orderFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: OrderFilter.values.map((filter) {
                final isSelected = filter == currentFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter.name.toUpperCase()),
                    selected: isSelected,
                    onSelected: (selected) {
                      ref.read(orderFilterProvider.notifier).state = filter;
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Orders list
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(allOrdersProvider);
              },
              child: ordersAsync.when(
                data: (orders) {
                  if (orders.isEmpty) {
                    return const Center(
                      child: Text('No orders found'),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(
                            order.soNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'PO: ${order.poNumber} • ${DateFormat('dd MMM yyyy').format(order.soDate)}',
                              ),
                              const SizedBox(height: 4),
                              _StatusChip(status: order.status),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            ref.read(selectedOrderProvider.notifier).state =
                                order.soNumber;
                            Routers.navigateTo(
                                context, OrderDetailPage.routeName);
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.invalidate(allOrdersProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  Color get _color {
    switch (status) {
      case 'PENDING':
        return Colors.orange;
      case 'APPROVED':
        return Colors.blue;
      case 'IN_PRODUCTION':
        return Colors.purple;
      case 'DISPATCHED':
        return Colors.teal;
      case 'DELIVERED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _color),
      ),
      child: Text(
        status.replaceAll('_', ' '),
        style: TextStyle(
          fontSize: 10,
          color: _color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
