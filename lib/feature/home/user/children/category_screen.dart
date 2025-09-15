import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/widgets/category_big_card_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import '../../../../custom_assets/assets.gen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// State for radio (only one selected at a time per section)
  String? _selectedDietary = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Browse by Cuisines',
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Assets.icons.filter.svg(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 166 / 187,
          ),
          itemCount: HelperData.category.length,
          itemBuilder: (context, index) {
            final data = HelperData.category[index];
            return CategoryBigCardWidget(
              onTap: (){
                Get.toNamed(AppRoutes.productViewScreen,arguments: data['title']);
              },
                data: data, index: index);
          },
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.bgColor,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  CustomText(
                    text: "Filter",
                    fontSize: 18.sp,
                  ),
                  Divider(color: AppColors.borderColor, thickness: 0.5),

                  /// Dietary Section (Radio)
                  CustomText(text: "Dietary", color: AppColors.appGreyColor),
                  ...["Vegan", "Vegetarian", "Halal", "Gluten Free"].map((item) {
                    return RadioListTile<String>(
                      selected: item == _selectedDietary ? true : false,
                      selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
                      activeColor: AppColors.primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: CustomText(textAlign: TextAlign.start, text: item),
                      value: item,
                      groupValue: _selectedDietary,
                      onChanged: (val) {
                        setState(() {
                          _selectedDietary = val;
                        });
                      },
                    );
                  }),

                  Divider(color: AppColors.borderColor, thickness: 0.5),

                  /// Cuisine Section (Radio)
                  CustomText(text: "Cuisine", color: AppColors.appGreyColor),
                  ...["Main", "Dessert", "Snacks", "Drinks", "Seafood"].map((item) {
                    return RadioListTile<String>(
                      selected: item == _selectedDietary ? true : false,
                      selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
                      activeColor: AppColors.primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: CustomText(textAlign: TextAlign.start, text: item),
                      value: item,
                      groupValue: _selectedDietary,
                      onChanged: (val) {
                        setState(() {
                          _selectedDietary = val;
                        });
                      },
                    );
                  }),

                  Divider(color: AppColors.borderColor, thickness: 0.5),

                  /// Fitness Flow (Radio)
                  CustomText(text: "Fitness Flow", color: AppColors.appGreyColor),
                  ...["Protein", "Low-Carbs", "Smoothies"].map((item) {
                    return RadioListTile<String>(
                      selected: item == _selectedDietary ? true : false,
                      selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
                      activeColor: AppColors.primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: CustomText(textAlign: TextAlign.start, text: item),
                      value: item,
                      groupValue: _selectedDietary,
                      onChanged: (val) {
                        setState(() {
                          _selectedDietary = val;
                        });
                      },
                    );
                  }),

                  Divider(color: AppColors.borderColor, thickness: 0.5),

                  /// Cheat Flow (Radio)
                  CustomText(text: "Cheat Flow", color: AppColors.appGreyColor),
                  ...["Comfort", "Sweet", "Street Food"].map((item) {
                    return RadioListTile<String>(
                      selected: item == _selectedDietary ? true : false,
                      selectedTileColor: AppColors.primaryColor.withOpacity(0.2),
                      activeColor: AppColors.primaryColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: CustomText(textAlign: TextAlign.start, text: item),
                      value: item,
                      groupValue: _selectedDietary,
                      onChanged: (val) {
                        setState(() {
                          _selectedDietary = val;
                        });
                      },
                    );
                  }),

                  SizedBox(height: 44.h),

                  /// Apply Button
                  CustomButton(
                    height: 38.h,
                    fontSize: 16.sp,
                    onPressed: () {
                      debugPrint("Dietary: $_selectedDietary");
                      Navigator.pop(context);
                    },
                    label: 'Apply filter',
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
