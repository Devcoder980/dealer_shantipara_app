import 'product.dart';

/// Order model
class Order {
  final int id;
  final String soNumber;
  final String poNumber;
  final int customerId;
  final DateTime soDate;
  final DateTime deliveryDate;
  final String paymentTerm;
  final String orderType;
  final String status;
  final bool isApproved;
  final bool hasInsufficientStock;
  final bool invoicePrepared;
  final bool isDeleted;
  final String salesPurpose;
  final List<String> activities;
  final Customer customer;
  final List<Product> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.soNumber,
    required this.poNumber,
    required this.customerId,
    required this.soDate,
    required this.deliveryDate,
    required this.paymentTerm,
    required this.orderType,
    required this.status,
    required this.isApproved,
    required this.hasInsufficientStock,
    required this.invoicePrepared,
    required this.isDeleted,
    required this.salesPurpose,
    required this.activities,
    required this.customer,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int? ?? 0,
      soNumber: json['soNumber'] as String? ?? '',
      poNumber: json['poNumber'] as String? ?? '',
      customerId: json['customerId'] as int? ?? 0,
      soDate: DateTime.tryParse(json['soDate'] ?? '') ?? DateTime.now(),
      deliveryDate:
          DateTime.tryParse(json['deliveryDate'] ?? '') ?? DateTime.now(),
      paymentTerm: json['paymentTerm'] as String? ?? '',
      orderType: json['orderType'] as String? ?? '',
      status: json['status'] as String? ?? 'PENDING',
      isApproved: json['isApproved'] as bool? ?? false,
      hasInsufficientStock: json['hasInsufficientStock'] as bool? ?? false,
      invoicePrepared: json['invoicePrepared'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      salesPurpose: json['salesPurpose'] as String? ?? '',
      activities: (json['activities'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      customer: Customer.fromJson(
          json['customer'] as Map<String, dynamic>? ?? {}),
      products: (json['product'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'soNumber': soNumber,
      'poNumber': poNumber,
      'customerId': customerId,
      'soDate': soDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'paymentTerm': paymentTerm,
      'orderType': orderType,
      'status': status,
      'isApproved': isApproved,
    };
  }
}

/// Customer model (nested in Order)
class Customer {
  final String name;
  final String email;
  final String? mobile;
  final String? address;

  Customer({
    required this.name,
    required this.email,
    this.mobile,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String?,
      address: json['address'] as String?,
    );
  }
}

/// Order stats response
class OrderStats {
  final int totalOrders;
  final int pendingOrders;
  final String thisMonthCommission;
  final DateTime? lastOrderDate;

  OrderStats({
    required this.totalOrders,
    required this.pendingOrders,
    required this.thisMonthCommission,
    this.lastOrderDate,
  });

  factory OrderStats.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return OrderStats(
      totalOrders: data['totalOrders'] as int? ?? 0,
      pendingOrders: data['pendingOrders'] as int? ?? 0,
      thisMonthCommission: data['thisMonthCommission'] as String? ?? '0.00',
      lastOrderDate: DateTime.tryParse(data['lastOrderDate'] ?? ''),
    );
  }
}

/// Orders list response
class OrdersResponse {
  final bool success;
  final List<Order> orders;

  OrdersResponse({
    required this.success,
    required this.orders,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return OrdersResponse(
      success: json['success'] as bool? ?? false,
      orders: (data['orders'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
