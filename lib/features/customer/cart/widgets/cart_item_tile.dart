import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../state/cart_state.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final food = item.food;
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.spacing(12)),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: responsive.size(56),
              height: responsive.size(56),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(responsive.radius(8)),
                child: Image.asset(AppAssets.foodPhotoGeneric, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: responsive.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleSmall),
                  SizedBox(height: responsive.spacing(4)),
                  Text(
                    '${AppStrings.currencySymbol}${food.price.toStringAsFixed(2)}',
                    style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                QuantitySelector(quantity: item.quantity, onIncrement: onIncrement, onDecrement: onDecrement),
                SizedBox(height: responsive.spacing(8)),
                InkWell(
                  onTap: onRemove,
                  child: Icon(Icons.delete_outline_rounded, size: responsive.iconSize(18), color: AppColors.error),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
