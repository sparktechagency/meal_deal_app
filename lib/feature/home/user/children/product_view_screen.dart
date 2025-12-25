import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/feature/home/user/children/map_screen.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/feature/home/widgets/products_card_widget.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import '../../../../app/helpers/menu_show_helper.dart';
import '../../../../custom_assets/assets.gen.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  final String appTitle = (Get.arguments as String?) ?? "Products";

  String selectedValueButton = 'Listing';

  static final List<Map<String, dynamic>> _bottomButton = [
    {"title": "Listing", "icon": Assets.icons.listing.path},
    {"title": "Map View", "icon": Assets.icons.mapView.path},
  ];

  final AddMealController _addMealController = Get.find<AddMealController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addMealController.getSeeAllMeals();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: selectedValueButton == 'Map View'
          ? null
          : CustomAppBar(title: appTitle),
      body: Stack(
        children: [
          if (selectedValueButton == 'Listing') _buildListingWidget(context),
          if (selectedValueButton == 'Map View') MapViewScreen(),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildListingWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CategoryItemWidget(categoryItem: HelperData.categoryItem),
          Expanded(
            child: GetBuilder<AddMealController>(
                builder: (controller) {
                  if(controller.isLoadingSeeAll){
                    return CustomLoader();
                  }
                  if (controller.seeAllMealData.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: 'No data available',
                        fontSize: 16.sp,
                      ),
                    );
                  }
                  final List<PopularMeals> dataList = controller.seeAllMealData;

                  return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 166 / 265,
                    ),
                    itemCount: dataList.length +
                        (controller.isLoadingSeeAllMore ? 1 : 0),
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == dataList.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Center(child: CustomLoader()),
                        );
                      }
                      final item = dataList[index];
                      return  ProductsCardWidget(
                        image: item.imageUrls?.firstOrNull ?? '',
                        title: item.mealName ?? '',
                        kcal: item.kcalories ?? '0.0 kcal',
                        portions: item.availablePortion ?? 0,
                        authorImage: item.cook?.profileImage ?? '',
                        author: item.cook?.cookName ?? '',
                        rating: item.cook?.rating ?? '',
                      );
                    },
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBottomButtons() {
    return Positioned(
      bottom: 6.h,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Center(
          child: CustomContainer(
            color: Colors.white,
            width: 200.w,
            height: 40.h,
            radiusAll: 100.r,
            child: Row(
              children: List.generate(_bottomButton.length, (index) {
                final item = _bottomButton[index];
                final isSelected = selectedValueButton == item["title"];
                return Expanded(
                  child: CustomContainer(
                    height: 30.h,
                    marginAll: 6.r,
                    onTap: () {
                      setState(() {
                        selectedValueButton = item["title"];
                      });
                    },
                    radiusAll: 100.r,
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          item["icon"],
                          color: isSelected
                              ? Colors.white
                              : AppColors.black04TextColor,
                          height: 16.h,
                          width: 16.w,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: item["title"],
                          color: isSelected
                              ? Colors.white
                              : AppColors.black04TextColor,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }


  void _addScrollListener() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _addMealController.loadMoreSeeMeals();
        debugPrint("load more true");
      }
    },
    );

  }
}