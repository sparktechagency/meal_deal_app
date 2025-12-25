import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/helpers/simmer_helper.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/feature/home/widgets/cooks_card_widget.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import '../../../app/utils/app_colors.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/products_card_widget.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  final AddMealController _addMealController = Get.find<AddMealController>();


  @override
  void initState() {
    if(_addMealController.mealData == null){
      _addMealController.getTestSales();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        titleWidget: GetBuilder<UserController>(
            builder: (controller) {
              return CustomListTile(
                imageRadius: 18.r,
                image: controller.useModelData?.profileImage ?? '',
                contentPaddingHorizontal: 16.w,
                titleColor: AppColors.black600TextColor,
                title: 'Welcome!',
                subTitle: controller.useModelData?.name ?? 'N/A',
                subtitleFontSize: 14.sp,
                titleFontSize: 15.sp,
                statusColor: AppColors.black800TextColor,
              );
            }
        ),
        actions: [
          GestureDetector(onTap: (){}, child: Icon(Icons.notifications_none_outlined,color: AppColors.primaryColor,)),
          IconButton(onPressed: (){
            Get.toNamed(AppRoutes.allCardScreen);
          }, icon: Icon(Icons.shopping_cart_outlined,color: AppColors.primaryColor,)),
        ],
      ),


      body: RefreshIndicator(
        onRefresh: () async {
          await _addMealController.getTestSales();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: GetBuilder<AddMealController>(
            builder: (controller) {
              final List<Meals>? meals = controller.mealData?.meals;
              List<TopRatedCooks>? topRatedCooks = controller.mealData?.topRatedCooks;
              List<PopularMeals>? popularMeals = controller.mealData?.popularMeals;
              if(controller.isLoadingTestSales){
                return ShimmerHelper.homeScreenShimmer();
              }else if(controller.mealData == null){
                return Center(
                  child: CustomText(text: 'No Data Found',fontSize: 16.sp,),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomTextField(
                      prefixIcon: Icon(Icons.search,color: AppColors.appGreyColor,),
                      hintText: 'What would you like to order today?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: AppColors.black500TextColor)
                      ),
                      validator: (_) => null,
                        controller: _searchController),
                  ),


                  LabelTitleWidget(title: 'Browse by Cuisines',onTap: (){
                    Get.toNamed(AppRoutes.categoryScreen);
                  }),

                  SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: HelperData.category.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        final data = HelperData.category[index];
                        return CategoryCardWidget(data: data,index: index,onTap: (){
                          Get.toNamed(AppRoutes.productViewScreen,arguments: data['title']);
                        },);
                      }),
                    ),

                  SizedBox(height: 10.h),
                  Divider(color: AppColors.borderColor,thickness: 0.5,),

                  LabelTitleWidget(title: 'Meals',onTap: (){
                    Get.toNamed(AppRoutes.productViewScreen,arguments: 'Meals');
                  }),

                  SizedBox(
                    height: 265.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: meals?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = meals?[index];
                        return ProductsCardWidget(
                          image: item?.imageUrls?.firstOrNull ?? '',
                          title: item?.mealName ?? '',
                          kcal: item?.kcalories ?? '0.0 kcal',
                          portions: item?.availablePortion ?? 0,
                          authorImage: item?.cookId?.profileImage ?? '',
                          author: item?.cookId?.cookName ?? '',
                          rating: item?.cookId?.rating ?? '',
                            index: index
                        );
                    },
                    ),
                  ),



                  SizedBox(height: 10.h),
                  Divider(color: AppColors.borderColor,thickness: 0.5,),

                  LabelTitleWidget(title: 'Top Rated Cooks',onTap: (){
                    Get.toNamed(AppRoutes.productViewScreen,arguments: 'Top Rated Cooks');

                  }),

                  SizedBox(
                    height: 210.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedCooks?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = topRatedCooks?[index];
                        return CooksCardWidget(
                          name: item?.cookName ?? '',
                          image: item?.profileImage ?? '',
                          rating: item?.rating?.toDouble() ?? 0.0,
                            index: index);
                    },),
                  ),


                  SizedBox(height: 10.h),
                  Divider(color: AppColors.borderColor,thickness: 0.5,),

                  LabelTitleWidget(title: 'Popular Meals',onTap: (){
                    Get.toNamed(AppRoutes.productViewScreen,arguments: 'Popular Meals');

                  }),

                  SizedBox(
                    height: 265.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularMeals?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = popularMeals?[index];
                        return ProductsCardWidget(
                            image: item?.imageUrls?.firstOrNull ?? '',
                            title: item?.mealName ?? '',
                            kcal: item?.kcalories ?? '0.0 kcal',
                            portions: item?.availablePortion ?? 0,
                            authorImage: item?.cook?.profileImage ?? '',
                            author: item?.cook?.cookName ?? '',
                            rating: item?.cook?.rating ?? '',
                            index: index
                        );
                    },),
                  ),

                  SizedBox(height: 24.h),

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}


