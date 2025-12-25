import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/otp_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/orders/orders_list_page.dart';
import '../pages/orders/order_detail_page.dart';

/// App router configuration
class Routers {
  Routers._();

  /// All app routes
  static Map<String, WidgetBuilder> get routes => {
        LoginPage.routeName: (context) => const LoginPage(),
        OtpPage.routeName: (context) => const OtpPage(),
        DashboardPage.routeName: (context) => const DashboardPage(),
        OrdersListPage.routeName: (context) => const OrdersListPage(),
        OrderDetailPage.routeName: (context) => const OrderDetailPage(),
      };

  /// Navigate to named route
  static Future<void> navigateTo(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  /// Navigate and replace current route
  static Future<void> navigateAndReplace(
      BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  /// Navigate and clear stack
  static Future<void> navigateAndClearStack(
      BuildContext context, String routeName) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }

  /// Pop current route
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
