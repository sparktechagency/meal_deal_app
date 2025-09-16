import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class CookViewScreen extends StatelessWidget {
  const CookViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomContainer(
                      height: 370.h,
                      width: double.infinity,
                      child: Assets.images.cookImage.image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    SizedBox(height: 100.h),
                   // _buildFilters(),
                    //SizedBox(height: 16.h),
                    ..._buildMenuItems(),
                  ],
                ),
                Positioned(
                    top: 280.h,
                    left: 24.w,
                    right: 24.w,
                    child: _buildProfileHeader()),

              ],
            ),
          ),
          Positioned(
            top: 0.h,
              left: 0.w,
              right: 0.w,
              child: CustomAppBar(backgroundColor: Colors.transparent,actions: [
              ])),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return CustomContainer(
      paddingAll: 16.w,
        color: Colors.white,
        radiusAll: 12.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "Jacob Jones",fontSize: 18.sp, fontWeight: FontWeight.w500),
          SizedBox(height: 6.h),
          Row(
            children: [
              Assets.icons.star.svg(),
              Flexible(child: CustomText(text: " 4.5 (232) •   13 km")),
            ],
          ),
          Divider(color: AppColors.black04TextColor,thickness: 0.5,height: 24.h,),
          CustomText(text: "Why I cook?",fontSize: 18.sp, fontWeight: FontWeight.w500),
          CustomText(text:
            "Lorem ipsum dolor sit amet consectetur.", color: AppColors.colorA0A0A0,
          ),
        ],
      ),
    );
  }
  /// Filter Buttons
  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.sort),
            label: const Text("Sort by"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        _chip("Seafood"),
        SizedBox(width: 8.w),
        _chip("Soup"),
      ],
    );
  }

  /// Menu Items
  List<Widget> _buildMenuItems() {
    final menu = [
      "Gujarati Dhebha",
      "Chicken Biryani",
      "Shaking Beef Tri-Tip",
      "Shaking Beef Tri-Tip",
      "Shaking Beef Tri-Tip",
    ];

    return menu.map((dish) {
      return _MenuCard(title: dish, price: 12.52, rating: 4.5, reviews: 232);
    }).toList();
  }

  /// Custom Chip
  Widget _chip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }

}





/// Menu Card Widget
class _MenuCard extends StatelessWidget {
  final String title;
  final double price;
  final double rating;
  final int reviews;

  const _MenuCard({
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Assets.images.img.image(
              width: 60.w,
              height: 60.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 6.h),
                Text("\$$price", style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16.sp),
                    Text(" $rating ($reviews)", style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
              ],
            ),
          ),

          // Add Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, size: 18),
            label: const Text("Add"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
