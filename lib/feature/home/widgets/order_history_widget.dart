import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/models/order/order_model_data.dart';
import '../../../widgets/widgets.dart';

class OrderHistoryWidget extends StatelessWidget {
  final OrderHistoryModelData item;

  const OrderHistoryWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: item.profileImage != null
            ? Image.network(
          item.profileImage!,
          width: 46.w,
          height: 46.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 46.w,
              height: 46.h,
              color: Colors.grey[300],
              child: Icon(Icons.restaurant, color: Colors.grey),
            );
          },
        )
            : Container(
          width: 46.w,
          height: 46.h,
          color: Colors.grey[300],
          child: Icon(Icons.restaurant, color: Colors.grey),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: item.status ?? 'Unknown',
            fontSize: 12.sp,
            color: _getStatusColor(item.status),
          ),
          CustomText(text: item.profileName ?? 'No Name'),
        ],
      ),
      subtitle: CustomText(
        textAlign: TextAlign.start,
        text: '${item.totalQuantity ?? 0} items',
        fontSize: 10.sp,
        color: AppColors.black300TextColor,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: _formatDate(item.createdAt),
            color: AppColors.black300TextColor,
            fontSize: 10.sp,
          ),
          CustomText(text: '\$ ${item.price ?? 0}'),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return Color(0xff16BD16);
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.primaryColor;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('MMM d • hh:mm a');
      return formatter.format(date);
    } catch (e) {
      return dateString;
    }
  }
}