import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/controllers/cook_controller.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/models/cooks/cook_details_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class CookViewScreen extends StatefulWidget {
  const CookViewScreen({super.key});

  @override
  State<CookViewScreen> createState() => _CookViewScreenState();
}

class _CookViewScreenState extends State<CookViewScreen> {
  final String cookID = Get.arguments ?? '';
  final CookController _cookController = Get.find<CookController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cookController.getMealDetails(cookID);
    });
  }

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

  /// Main Scrollable Content
  Widget _buildContent() {
    return GetBuilder<CookController>(
      builder: (controller) {
        // Loading State
        if (controller.isLoadingDetails) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error State
        if (controller.cookDetailsModelData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64.r, color: Colors.red),
                SizedBox(height: 16.h),
                CustomText(text: 'Failed to load cook details'),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => controller.getMealDetails(cookID),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final cookData = controller.cookDetailsModelData?.cook;
        final meals = controller.cookDetailsModelData?.meals;

        // Empty State
        if (cookData == null) {
          return const Center(child: CustomText(text: 'No data available'));
        }

        return SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  // Profile Image
                  CustomContainer(
                    height: 370.h,
                    width: double.infinity,
                    child: CustomNetworkImage(
                      imageUrl: cookData.profileImage ?? '',
                      height: 370.h,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 70.h),

                  // Category Filter
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CategoryItemWidget(
                      categoryItem: HelperData.categoryItem,
                    ),
                  ),

                  // Meals List
                  if (meals != null && meals.isNotEmpty)
                    ListView.builder(
                      padding: EdgeInsets.only(top: 16.h, bottom: 40.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: meals.length,
                      itemBuilder: (context, index) {
                        return _menuCardWidget(meals[index]);
                      },
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                        child: CustomText(
                          text: 'No meals available',
                          color: AppColors.colorA0A0A0,
                        ),
                      ),
                    ),
                ],
              ),

              // Floating Profile Card
              Positioned(
                top: 280.h,
                left: 24.w,
                right: 24.w,
                child: _buildProfileHeader(cookData),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuCardWidget(Meals meal) {
    return CustomContainer(
      onTap: () {
        // Pass meal ID to details screen
        Get.toNamed(
          AppRoutes.productDetailsScreen,
          arguments: meal.sId,
        );
      },
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 5,
        ),
      ],
      verticalMargin: 6.h,
      horizontalMargin: 16.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        children: [
          // Meal Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CustomNetworkImage(
              imageUrl: meal.imageUrls?.first ?? '',
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Meal Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  maxline: 1,
                  textOverflow: TextOverflow.ellipsis,
                  text: meal.mealName ?? 'N/A',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "\$${meal.price?.toStringAsFixed(2) ?? '0.00'}",
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  top: 2.h,
                  bottom: 6.h,
                ),
                Row(
                  children: [
                    Assets.icons.star.svg(),
                    CustomText(
                      text: " ${meal.rating?.toStringAsFixed(1) ?? 'N/A'}",
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Add to Cart Button
          ElevatedButton.icon(
            onPressed: () {
              // Add to cart logic should be here
             // _cookController.addToCart(meal);
              Get.snackbar(
                'Added to Cart',
                '${meal.mealName} added successfully',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            icon: Icon(Icons.shopping_cart, size: 14.r),
            label: CustomText(text: "Add", fontSize: 12.sp),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.black600TextColor,
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.black600TextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Profile Header Card
  Widget _buildProfileHeader(Cook cookData) {
    return CustomContainer(
      paddingAll: 16.w,
      color: Colors.white,
      radiusAll: 12.r,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: cookData.cookName ?? 'N/A',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Assets.icons.star.svg(),
              Flexible(
                child: CustomText(
                  text: " ${cookData.rating?.toStringAsFixed(1) ?? '0.0'} • "
                      "${14 ?? '0'} km",
                  fontSize: 14.sp,
                ),
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: cookData.shortDescription ?? 'No description available',
            color: AppColors.colorA0A0A0,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  /// Transparent App Bar
  Widget _buildAppBar() {
    return Positioned(
      top: 0.h,
      left: 0.w,
      right: 0.w,
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        actions: [
          GetBuilder<CookController>(
            builder: (controller) {
             // final isFavorite = controller.isCookFavorite(cookID);
              return GestureDetector(
                onTap: () {} ,
                child: Assets.icons.love.svg(),
              );
            },
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.cookDetailsScreen,
                arguments: cookID,
              );
            },
            icon: Assets.icons.info.svg(),
          ),
        ],
      ),
    );
  }
}