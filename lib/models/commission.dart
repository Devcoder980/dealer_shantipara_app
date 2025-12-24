/// Commission summary response
class CommissionSummary {
  final bool success;
  final CommissionData summary;
  final List<CommissionOrder> orders;

  CommissionSummary({
    required this.success,
    required this.summary,
    required this.orders,
  });

  factory CommissionSummary.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return CommissionSummary(
      success: json['success'] as bool? ?? false,
      summary:
          CommissionData.fromJson(data['summary'] as Map<String, dynamic>? ?? {}),
      orders: (data['orders'] as List<dynamic>?)
              ?.map((e) => CommissionOrder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Commission data summary
class CommissionData {
  final int totalOrders;
  final String totalCommission;
  final String totalAmount;
  final String totalDealerAmount;
  final String averageCommissionPercentage;

  CommissionData({
    required this.totalOrders,
    required this.totalCommission,
    required this.totalAmount,
    required this.totalDealerAmount,
    required this.averageCommissionPercentage,
  });

  factory CommissionData.fromJson(Map<String, dynamic> json) {
    return CommissionData(
      totalOrders: json['totalOrders'] as int? ?? 0,
      totalCommission: json['totalCommission'] as String? ?? '0.00',
      totalAmount: json['totalAmount'] as String? ?? '0.00',
      totalDealerAmount: json['totalDealerAmount'] as String? ?? '0.00',
      averageCommissionPercentage:
          json['averageCommissionPercentage'] as String? ?? '0.00',
    );
  }

  /// Get formatted total commission
  String get formattedCommission => '₹$totalCommission';

  /// Get formatted total amount
  String get formattedAmount => '₹$totalAmount';
}

/// Commission order
class CommissionOrder {
  final String soNumber;
  final DateTime soDate;
  final String customerName;
  final String totalAmount;
  final String dealerAmount;
  final String commission;
  final String commissionPercentage;
  final String status;
  final int itemCount;
  final List<CommissionProduct> products;

  CommissionOrder({
    required this.soNumber,
    required this.soDate,
    required this.customerName,
    required this.totalAmount,
    required this.dealerAmount,
    required this.commission,
    required this.commissionPercentage,
    required this.status,
    required this.itemCount,
    required this.products,
  });

  factory CommissionOrder.fromJson(Map<String, dynamic> json) {
    return CommissionOrder(
      soNumber: json['soNumber'] as String? ?? '',
      soDate: DateTime.tryParse(json['soDate'] ?? '') ?? DateTime.now(),
      customerName: json['customerName'] as String? ?? '',
      totalAmount: json['totalAmount'] as String? ?? '0.00',
      dealerAmount: json['dealerAmount'] as String? ?? '0.00',
      commission: json['commission'] as String? ?? '0.00',
      commissionPercentage: json['commissionPercentage'] as String? ?? '0.00',
      status: json['status'] as String? ?? '',
      itemCount: json['itemCount'] as int? ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => CommissionProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Get formatted commission
  String get formattedCommission => '₹$commission';
}

/// Commission product
class CommissionProduct {
  final int id;
  final String rollType;
  final String sellingType;
  final int quantity;
  final double unitPrice;
  final double dealerUnitPrice;
  final String totalAmount;
  final String totalDealerAmount;
  final String commission;
  final String description;

  CommissionProduct({
    required this.id,
    required this.rollType,
    required this.sellingType,
    required this.quantity,
    required this.unitPrice,
    required this.dealerUnitPrice,
    required this.totalAmount,
    required this.totalDealerAmount,
    required this.commission,
    required this.description,
  });

  factory CommissionProduct.fromJson(Map<String, dynamic> json) {
    return CommissionProduct(
      id: json['id'] as int? ?? 0,
      rollType: json['rollType'] as String? ?? '',
      sellingType: json['sellingType'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      dealerUnitPrice: (json['dealerUnitPrice'] as num?)?.toDouble() ?? 0.0,
      totalAmount: json['totalAmount'] as String? ?? '0.00',
      totalDealerAmount: json['totalDealerAmount'] as String? ?? '0.00',
      commission: json['commission'] as String? ?? '0.00',
      description: json['description'] as String? ?? '',
    );
  }
}
