import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final String mealsID = Get.arguments as String ?? '';
  final AddMealController _addMealController = Get.find<AddMealController>();
  bool isWarm = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addMealController.getMealDetails(mealsID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: GetBuilder<AddMealController>(
        builder: (controller) {
          // Check if data is loading
          if (controller.isLoadingDetails) {
            return const Center(child: CircularProgressIndicator());
          }

          // Get meal details
          final mealData = controller.mealDataDetails;

          // Check if data is null
          if (mealData == null) {
            return const Center(child: Text('No data available'));
          }

          // Calculate total price
          double basePrice = mealData.pricePerPortion ?? 0.0;
          double warmPrice = mealData.coldReheatPrice ?? 0.0;
          double totalTk = isWarm ? basePrice + warmPrice : basePrice;

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 280.h,
                  floating: false,
                  pinned: false,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  backgroundColor: AppColors.bgColor,
                  leading: IconButton(
                    icon: Assets.icons.backButton.svg(height: 32.h, width: 32.w),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Assets.icons.love.svg(),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      bottom: false,
                      child: CustomContainer(
                        color: AppColors.bgColor,
                        image: mealData.imageUrls != null && mealData.imageUrls!.isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(mealData.imageUrls![0]),
                          fit: BoxFit.cover,
                        )
                            : DecorationImage(
                          image: AssetImage(Assets.images.img.path),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: 'Category : ${mealData.category ?? "Main"}',
                                  color: AppColors.black400TextColor,
                                  bottom: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: mealData.timeForPickUpFood ?? '30 Mins for Pick Up',
                                      color: AppColors.black400TextColor,
                                      bottom: 8.h,
                                    ),
                                    CustomText(
                                      text: '${mealData.kcalories ?? "450"} kcal',
                                      color: AppColors.black400TextColor,
                                      bottom: 8.h,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /// ===============>>> Title Section ================>>
                  CustomContainer(
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          title: CustomText(
                            textAlign: TextAlign.start,
                            text: mealData.mealName ?? 'Meal Name',
                            fontSize: 20.sp,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.icons.star.svg(height: 14.h, width: 14.w),
                              CustomText(
                                left: 2.w,
                                text: "${mealData.rating ?? 0.0} (233)  •",
                                fontSize: 11.sp,
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.location_on,
                                  size: 14.sp, color: AppColors.black600TextColor),
                              CustomText(
                                text: mealData.location ?? '1.3 km',
                                fontSize: 11.sp,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomText(
                            top: 6.h,
                            bottom: 16.h,
                            text: mealData.description ??
                                'No description available',
                            fontSize: 14.sp,
                            color: AppColors.colorA0A0A0,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ===============>>> Ingredients ================>>
                  CustomContainer(
                    radiusAll: 8.r,
                    horizontalMargin: 24.w,
                    verticalMargin: 16.h,
                    paddingAll: 10.r,
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Ingredients',
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          top: 6.h,
                          text: mealData.ingredients?.join(', ') ?? 'No ingredients listed',
                          fontSize: 16.sp,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  /// ===============>>> Available Portion & Offer ================>>
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomContainer(
                            radiusAll: 8.r,
                            paddingAll: 10.r,
                            elevation: true,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Available Portion',
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.start,
                                ),
                                CustomText(
                                  top: 6.h,
                                  text: '${mealData.availablePortion ?? 0}',
                                  fontSize: 16.sp,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: CustomContainer(
                            radiusAll: 8.r,
                            paddingAll: 10.r,
                            elevation: true,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Offer (Optional)',
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.start,
                                ),
                                CustomText(
                                  top: 6.h,
                                  text: mealData.offer ?? '0% Off',
                                  fontSize: 16.sp,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ===============>>> Allergy Info ================>>
                  CustomContainer(
                    radiusAll: 8.r,
                    horizontalMargin: 24.w,
                    verticalMargin: 16.w,
                    paddingAll: 10.r,
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Allergy Info',
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          top: 4.h,
                          text: mealData.allergyInformation ?? 'No allergy information',
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          top: 6.h,
                          text: 'Prepared in a kitchen that handles various allergens.',
                          color: AppColors.colorA0A0A0,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  /// ===============>>> Warm/Cold Status ================>>
                  CustomContainer(
                    horizontalMargin: 24.w,
                    radiusAll: 8.r,
                    paddingHorizontal: 10.r,
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        textAlign: TextAlign.start,
                        text: 'Warm/Cold Status',
                        color: AppColors.colorA0A0A0,
                      ),
                      subtitle: CustomText(
                        textAlign: TextAlign.start,
                        text: '${mealData.servedWarm ?? "Warm"}     \$${warmPrice.toStringAsFixed(2)}',
                      ),
                      trailing: Switch(
                        value: isWarm,
                        onChanged: (value) {
                          setState(() {
                            isWarm = value;
                          });
                        },
                      ),
                    ),
                  ),

                  /// ===============>>> Time for Order ================>>
                  CustomContainer(
                    horizontalMargin: 24.w,
                    verticalMargin: 16.h,
                    radiusAll: 8.r,
                    paddingAll: 10.r,
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          color: AppColors.colorA0A0A0,
                          text: 'Time for Order',
                          fontSize: 14.sp,
                          textAlign: TextAlign.start,
                        ),
                        CustomText(
                          top: 6.h,
                          text: mealData.timeForOrder ?? '9 AM - 12 PM',
                          fontSize: 12.sp,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  /// ===============>>> Additional Info ================>>
                  CustomContainer(
                    horizontalMargin: 24.w,
                    verticalMargin: 8.h,
                    radiusAll: 8.r,
                    paddingAll: 10.r,
                    elevation: true,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Cuisine',
                                  color: AppColors.colorA0A0A0,
                                  fontSize: 12.sp,
                                ),
                                CustomText(
                                  top: 4.h,
                                  text: mealData.cuisineName ?? 'N/A',
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Dietary',
                                  color: AppColors.colorA0A0A0,
                                  fontSize: 12.sp,
                                ),
                                CustomText(
                                  top: 4.h,
                                  text: mealData.dietaryCategories ?? 'N/A',
                                  fontSize: 14.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<AddMealController>(
        builder: (controller) {
          final mealData = controller.mealDataDetails;
          if (mealData == null) return const SizedBox.shrink();

          double basePrice = mealData.pricePerPortion ?? 0.0;
          double warmPrice = mealData.coldReheatPrice ?? 0.0;
          double totalTk = isWarm ? basePrice + warmPrice : basePrice;

          return SafeArea(
            top: false,
            child: CustomContainer(
              onTap: () {
                Get.toNamed(AppRoutes.cardScreen);
              },
              marginAll: 16.r,
              radiusAll: 8.r,
              paddingAll: 12.r,
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomText(
                      text: 'Add to cart',
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  CustomText(
                    text: '\$ ${totalTk.toStringAsFixed(2)}',
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}