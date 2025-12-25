import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/provider.dart';
import '../routes/routers.dart';
import '../utils/hive_config.dart';
import 'login_page.dart';
import 'orders/orders_list_page.dart';

/// Dashboard page with stats and navigation
class DashboardPage extends ConsumerWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderStats = ref.watch(orderStatsProvider);
    final dealerName = DealerStorage.getDealerName();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                Routers.navigateAndClearStack(context, LoginPage.routeName);
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(orderStatsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome
              Text(
                'Welcome, $dealerName',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Stats cards
              orderStats.when(
                data: (stats) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'Total Orders',
                            value: stats.totalOrders.toString(),
                            icon: Icons.receipt_long,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatCard(
                            title: 'Pending',
                            value: stats.pendingOrders.toString(),
                            icon: Icons.pending_actions,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'This Month',
                            value: '₹${stats.thisMonthCommission}',
                            icon: Icons.currency_rupee,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatCard(
                            title: 'Last Order',
                            value: stats.lastOrderDate != null
                                ? DateFormat('dd MMM')
                                    .format(stats.lastOrderDate!)
                                : 'N/A',
                            icon: Icons.calendar_today,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Text('Error: $error'),
                ),
              ),

              const SizedBox(height: 32),

              // Quick actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              _ActionCard(
                title: 'View Orders',
                subtitle: 'See all your orders and track status',
                icon: Icons.list_alt,
                onTap: () =>
                    Routers.navigateTo(context, OrdersListPage.routeName),
              ),
              const SizedBox(height: 12),

              _ActionCard(
                title: 'Commission Report',
                subtitle: 'View monthly commission details',
                icon: Icons.analytics,
                onTap: () {
                  // TODO: Navigate to commission page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1E88E5).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF1E88E5)),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
