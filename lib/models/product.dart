/// Product model
class Product {
  final int id;
  final String rollType;
  final String sellingType;
  final String width;
  final String length;
  final String film;
  final String coat;
  final String color;
  final String? colorCode;
  final String printingMatter;
  final String quantity;
  final String boxQuantity;
  final String? looseRolls;
  final String rollsPerBox;
  final String amount;
  final String dealerAmount;
  final String? brand;
  final String micron;
  final String? mic;
  final String? description;
  final List<String> printColors;
  final List<OrderItemStage> orderItemStages;
  final List<ProductionJob>? productionJobs;
  final Cylinder? cylinder;
  final List<QuantityStage>? quantityStage;

  Product({
    required this.id,
    required this.rollType,
    required this.sellingType,
    required this.width,
    required this.length,
    required this.film,
    required this.coat,
    required this.color,
    this.colorCode,
    required this.printingMatter,
    required this.quantity,
    required this.boxQuantity,
    this.looseRolls,
    required this.rollsPerBox,
    required this.amount,
    required this.dealerAmount,
    this.brand,
    required this.micron,
    this.mic,
    this.description,
    required this.printColors,
    required this.orderItemStages,
    this.productionJobs,
    this.cylinder,
    this.quantityStage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      rollType: json['rollType'] as String? ?? '',
      sellingType: json['sellingType'] as String? ?? '',
      width: json['width'] as String? ?? '',
      length: json['length'] as String? ?? '',
      film: json['film'] as String? ?? '',
      coat: json['coat'] as String? ?? '',
      color: json['color'] as String? ?? '',
      colorCode: json['colorCode'] as String?,
      printingMatter: json['printingMatter'] as String? ?? '',
      quantity: json['quantity'] as String? ?? '0',
      boxQuantity: json['boxQuantity'] as String? ?? '0',
      looseRolls: json['looseRolls'] as String?,
      rollsPerBox: json['rollsPerBox'] as String? ?? '0',
      amount: json['amount'] as String? ?? '',
      dealerAmount: json['dealerAmount'] as String? ?? '',
      brand: json['brand'] as String?,
      micron: json['micron'] as String? ?? '',
      mic: json['mic'] as String?,
      description: json['description'] as String?,
      printColors: (json['printColors'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      orderItemStages: (json['orderItemStages'] as List<dynamic>?)
              ?.map((e) => OrderItemStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productionJobs: (json['productionJobs'] as List<dynamic>?)
          ?.map((e) => ProductionJob.fromJson(e as Map<String, dynamic>))
          .toList(),
      cylinder: json['cylinder'] != null
          ? Cylinder.fromJson(json['cylinder'] as Map<String, dynamic>)
          : null,
      quantityStage: (json['quantityStage'] as List<dynamic>?)
          ?.map((e) => QuantityStage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get product display description
  String get displayDescription {
    return '$width MM x $length Meter $mic MIC $color ($printingMatter)';
  }
}

/// Order item stage
class OrderItemStage {
  final int id;
  final int productId;
  final String stage;
  final String status;
  final DateTime timestamp;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;

  OrderItemStage({
    required this.id,
    required this.productId,
    required this.stage,
    required this.status,
    required this.timestamp,
    this.notes,
    required this.completed,
    this.completedAt,
  });

  factory OrderItemStage.fromJson(Map<String, dynamic> json) {
    return OrderItemStage(
      id: json['id'] as int? ?? 0,
      productId: json['productId'] as int? ?? 0,
      stage: json['stage'] as String? ?? '',
      status: json['status'] as String? ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      notes: json['notes'] as String?,
      completed: json['completed'] as bool? ?? false,
      completedAt: DateTime.tryParse(json['completedAt'] ?? ''),
    );
  }
}

/// Production job
class ProductionJob {
  final int id;
  final String jobNumber;
  final int productId;
  final String currentDepartment;
  final String? assignedTo;
  final int quantity;
  final int completedQuantity;
  final String priority;
  final String status;
  final String? instructions;

  ProductionJob({
    required this.id,
    required this.jobNumber,
    required this.productId,
    required this.currentDepartment,
    this.assignedTo,
    required this.quantity,
    required this.completedQuantity,
    required this.priority,
    required this.status,
    this.instructions,
  });

  factory ProductionJob.fromJson(Map<String, dynamic> json) {
    return ProductionJob(
      id: json['id'] as int? ?? 0,
      jobNumber: json['jobNumber'] as String? ?? '',
      productId: json['productId'] as int? ?? 0,
      currentDepartment: json['currentDepartment'] as String? ?? '',
      assignedTo: json['assignedTo'] as String?,
      quantity: json['quantity'] as int? ?? 0,
      completedQuantity: json['completedQuantity'] as int? ?? 0,
      priority: json['priority'] as String? ?? 'MEDIUM',
      status: json['status'] as String? ?? '',
      instructions: json['instructions'] as String?,
    );
  }
}

/// Cylinder
class Cylinder {
  final int id;
  final String cylinderNumber;
  final String name;
  final String size;
  final String colour;
  final int usageCount;
  final int meterUsed;
  final String serialNumber;

  Cylinder({
    required this.id,
    required this.cylinderNumber,
    required this.name,
    required this.size,
    required this.colour,
    required this.usageCount,
    required this.meterUsed,
    required this.serialNumber,
  });

  factory Cylinder.fromJson(Map<String, dynamic> json) {
    return Cylinder(
      id: json['id'] as int? ?? 0,
      cylinderNumber: json['cylinderNumber'] as String? ?? '',
      name: json['name'] as String? ?? '',
      size: json['size'] as String? ?? '',
      colour: json['colour'] as String? ?? '',
      usageCount: json['usageCount'] as int? ?? 0,
      meterUsed: json['meterUsed'] as int? ?? 0,
      serialNumber: json['serialNumber'] as String? ?? '',
    );
  }
}

/// Quantity stage
class QuantityStage {
  final int id;
  final int productId;
  final String productType;
  final int totalQuantity;
  final int completedQuantity;
  final int pendingQuantity;
  final int totalBoxes;
  final int completedBoxes;
  final int pendingBoxes;
  final String status;

  QuantityStage({
    required this.id,
    required this.productId,
    required this.productType,
    required this.totalQuantity,
    required this.completedQuantity,
    required this.pendingQuantity,
    required this.totalBoxes,
    required this.completedBoxes,
    required this.pendingBoxes,
    required this.status,
  });

  factory QuantityStage.fromJson(Map<String, dynamic> json) {
    return QuantityStage(
      id: json['id'] as int? ?? 0,
      productId: json['productId'] as int? ?? 0,
      productType: json['productType'] as String? ?? '',
      totalQuantity: json['totalQuantity'] as int? ?? 0,
      completedQuantity: json['completedQuantity'] as int? ?? 0,
      pendingQuantity: json['pendingQuantity'] as int? ?? 0,
      totalBoxes: json['totalBoxes'] as int? ?? 0,
      completedBoxes: json['completedBoxes'] as int? ?? 0,
      pendingBoxes: json['pendingBoxes'] as int? ?? 0,
      status: json['status'] as String? ?? '',
    );
  }
}
