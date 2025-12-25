import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/order_provider.dart';

/// Order detail page
class OrderDetailPage extends ConsumerWidget {
  static const String routeName = '/order-detail';

  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soNumber = ref.watch(selectedOrderProvider);

    if (soNumber == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order Detail')),
        body: const Center(child: Text('No order selected')),
      );
    }

    final orderAsync = ref.watch(orderDetailProvider(soNumber));

    return Scaffold(
      appBar: AppBar(
        title: Text(soNumber),
      ),
      body: orderAsync.when(
        data: (order) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order info card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      _InfoRow('SO Number', order.soNumber),
                      _InfoRow('PO Number', order.poNumber),
                      _InfoRow(
                          'SO Date', DateFormat('dd MMM yyyy').format(order.soDate)),
                      _InfoRow('Delivery Date',
                          DateFormat('dd MMM yyyy').format(order.deliveryDate)),
                      _InfoRow('Status', order.status),
                      _InfoRow('Payment Term', order.paymentTerm),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Customer info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Customer Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      _InfoRow('Name', order.customer.name),
                      _InfoRow('Email', order.customer.email),
                      if (order.customer.mobile != null)
                        _InfoRow('Mobile', order.customer.mobile!),
                      if (order.customer.address != null)
                        _InfoRow('Address', order.customer.address!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Products
              const Text(
                'Products',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ...order.products.map((product) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.displayDescription,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 16,
                            runSpacing: 8,
                            children: [
                              _Chip('Width: ${product.width}mm'),
                              _Chip('Length: ${product.length}m'),
                              _Chip('Color: ${product.color}'),
                              _Chip('Boxes: ${product.boxQuantity}'),
                              _Chip('Rolls/Box: ${product.rollsPerBox}'),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price: ${product.amount}'),
                              Text('Dealer: ${product.dealerAmount}'),
                            ],
                          ),
                          if (product.orderItemStages.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Stage: ${product.orderItemStages.first.stage} (${product.orderItemStages.first.status})',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )),

              // Activities
              if (order.activities.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Activity Log',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.activities.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.history, size: 20),
                        title: Text(
                          order.activities[index],
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
