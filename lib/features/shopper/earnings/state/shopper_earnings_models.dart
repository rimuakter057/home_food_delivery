enum ShopperEarningsPeriod { today, thisWeek, monthly }

class ShopperBreakdownBarModel {
  const ShopperBreakdownBarModel({required this.label, required this.heightFraction, this.highlighted = false});

  final String label;
  final double heightFraction;
  final bool highlighted;
}

class ShopperEarningsSummaryModel {
  const ShopperEarningsSummaryModel({
    required this.amount,
    required this.deliveries,
    required this.avgPerDelivery,
    required this.bars,
  });

  final double amount;
  final int deliveries;
  final double avgPerDelivery;
  final List<ShopperBreakdownBarModel> bars;
}

class ShopperPayoutModel {
  const ShopperPayoutModel({required this.date, required this.deliveries, required this.amount, required this.isPaid});

  final String date;
  final int deliveries;
  final double amount;
  final bool isPaid;
}
