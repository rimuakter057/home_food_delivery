import 'shopper_earnings_models.dart';

class ShopperEarningsMockData {
  ShopperEarningsMockData._();

  static const double availableBalance = 284.50;
  static const int onlineHours = 28;

  static const Map<ShopperEarningsPeriod, ShopperEarningsSummaryModel> summaries = {
    ShopperEarningsPeriod.today: ShopperEarningsSummaryModel(
      amount: 47.50,
      deliveries: 6,
      avgPerDelivery: 7.92,
      bars: [
        ShopperBreakdownBarModel(label: 'Morning', heightFraction: 0.45),
        ShopperBreakdownBarModel(label: 'Afternoon', heightFraction: 0.65),
        ShopperBreakdownBarModel(label: 'Evening', heightFraction: 1.0, highlighted: true),
      ],
    ),
    ShopperEarningsPeriod.thisWeek: ShopperEarningsSummaryModel(
      amount: 534.93,
      deliveries: 53,
      avgPerDelivery: 8.22,
      bars: [
        ShopperBreakdownBarModel(label: 'Mon', heightFraction: 0.44),
        ShopperBreakdownBarModel(label: 'Tue', heightFraction: 0.40),
        ShopperBreakdownBarModel(label: 'Wed', heightFraction: 0.70),
        ShopperBreakdownBarModel(label: 'Thu', heightFraction: 0.57),
        ShopperBreakdownBarModel(label: 'Fri', heightFraction: 0.94),
        ShopperBreakdownBarModel(label: 'Sat', heightFraction: 1.0),
        ShopperBreakdownBarModel(label: 'Sun', heightFraction: 0.50, highlighted: true),
      ],
    ),
    ShopperEarningsPeriod.monthly: ShopperEarningsSummaryModel(
      amount: 2145.60,
      deliveries: 212,
      avgPerDelivery: 8.15,
      bars: [
        ShopperBreakdownBarModel(label: 'Wk 1', heightFraction: 0.5),
        ShopperBreakdownBarModel(label: 'Wk 2', heightFraction: 0.45),
        ShopperBreakdownBarModel(label: 'Wk 3', heightFraction: 0.3),
        ShopperBreakdownBarModel(label: 'Wk 4', heightFraction: 1.0, highlighted: true),
      ],
    ),
  };

  static const List<ShopperPayoutModel> payoutHistory = [
    ShopperPayoutModel(date: 'Feb 28, 2026', deliveries: 35, amount: 284.50, isPaid: true),
    ShopperPayoutModel(date: 'Feb 21, 2026', deliveries: 35, amount: 284.50, isPaid: true),
    ShopperPayoutModel(date: 'Feb 14, 2026', deliveries: 35, amount: 284.50, isPaid: true),
  ];
}
