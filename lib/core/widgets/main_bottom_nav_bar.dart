import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_helper.dart';

typedef NavBarItem = ({String label, String asset});

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = _customerItems,
    this.cartBadgeCount = 0,
    this.badgeIndex = 3,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavBarItem> items;
  final int cartBadgeCount;

  /// Index of the item that shows [cartBadgeCount] as a badge — defaults to
  /// the customer nav's Cart tab (index 3).
  final int badgeIndex;

  static const _customerItems = [
    (label: 'Home', asset: AppAssets.navHome),
    (label: 'Stores', asset: AppAssets.navStores),
    (label: 'Orders', asset: AppAssets.navOrders),
    (label: 'Cart', asset: AppAssets.navCart),
    (label: 'Profile', asset: AppAssets.navProfile),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.navBarBorder)),
        boxShadow: [
          BoxShadow(
            color: AppColors.navBarShadow,
            blurRadius: responsive.spacing(6),
            offset: Offset(0, -responsive.spacing(2)),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: responsive.padding(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;
              final showBadge = index == badgeIndex && cartBadgeCount > 0;
              final color = isSelected ? AppColors.primary : AppColors.textSecondary;

              return InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(responsive.radius(12)),
                child: Padding(
                  padding: responsive.padding(horizontal: 4, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SvgPicture.asset(
                            item.asset,
                            width: responsive.iconSize(22),
                            height: responsive.iconSize(22),
                            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                          ),
                          if (showBadge)
                            Positioned(
                              right: -responsive.spacing(6),
                              top: -responsive.spacing(4),
                              child: Container(
                                padding: responsive.padding(all: 3),
                                constraints: BoxConstraints(minWidth: responsive.size(16), minHeight: responsive.size(16)),
                                decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                                child: Text(
                                  '$cartBadgeCount',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: responsive.fontSize(9), fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: responsive.spacing(4)),
                      Text(
                        item.label,
                        style: (isSelected ? AppTextStyles.labelSmall : AppTextStyles.bodySmall).copyWith(color: color),
                      ),
                      if (isSelected) ...[
                        SizedBox(height: responsive.spacing(4)),
                        Container(
                          width: responsive.size(6),
                          height: responsive.size(6),
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
