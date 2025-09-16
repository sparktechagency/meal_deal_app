import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
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
          _buildContent(),
          _buildAppBar(),
        ],
      ),
    );
  }

  /// ===============================
  /// Main Scrollable Content
  /// ===============================
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeaderImage(),
              SizedBox(height: 70.h),
              _buildCategory(),
              _buildMenuList(),
            ],
          ),
          Positioned(
            top: 280.h,
            left: 24.w,
            right: 24.w,
            child: _buildProfileHeader(),
          ),
        ],
      ),
    );
  }

  /// ===============================
  /// Header Image Section
  /// ===============================
  Widget _buildHeaderImage() {
    return CustomContainer(
      height: 370.h,
      width: double.infinity,
      child: Assets.images.cookImage.image(
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  /// ===============================
  /// Category Section
  /// ===============================
  Widget _buildCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: const CategoryItemWidget(),
    );
  }

  /// ===============================
  /// Menu Items List
  /// ===============================
  Widget _buildMenuList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.h, bottom: 40.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const MenuCard(
          title: 'Fondue',
          rating: 4.2,
          reviews: 232,
          price: 12.52,
        );
      },
    );
  }

  /// ===============================
  /// Profile Header Card
  /// ===============================
  Widget _buildProfileHeader() {
    return CustomContainer(
      paddingAll: 16.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Jacob Jones",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Assets.icons.star.svg(),
              Flexible(
                child: CustomText(text: " 4.5 (232) • 13 km"),
              ),
            ],
          ),
          Divider(
            color: AppColors.black04TextColor,
            thickness: 0.5,
            height: 24.h,
          ),
          CustomText(
            text: "Why I cook?",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: "Lorem ipsum dolor sit amet consectetur.",
            color: AppColors.colorA0A0A0,
          ),
        ],
      ),
    );
  }

  /// ===============================
  /// Transparent App Bar
  /// ===============================
  Widget _buildAppBar() {
    return Positioned(
      top: 0.h,
      left: 0.w,
      right: 0.w,
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Assets.icons.love.svg(),
          ),
          IconButton(
            onPressed: () {},
            icon: Assets.icons.info.svg(),
          ),
        ],
      ),
    );
  }
}






/// Menu Card Widget
class MenuCard extends StatelessWidget {
  final String title;
  final double price;
  final double rating;
  final int reviews;

  const MenuCard({super.key, required this.title, required this.price, required this.rating, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h,horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Thumbnail
          Assets.images.img.image(
            width: 60.w,
            height: 60.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title, fontSize: 16.sp),
                CustomText(text:"\$$price",color: AppColors.primaryColor,top: 2.h,bottom: 6.h,),
                Row(
                  children: [
                    Assets.icons.star.svg(),
                    CustomText(text:" $rating ($reviews)",fontSize: 12.sp),
                  ],
                ),
              ],
            ),
          ),

          // Add Button
          ElevatedButton.icon(
            onPressed: () {},
            icon:  Icon(Icons.shopping_cart, size: 18.r),
            label: const CustomText(text: "Add"),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.black600TextColor,
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.black600TextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
