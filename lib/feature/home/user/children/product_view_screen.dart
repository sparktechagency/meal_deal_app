import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/user/children/map_screen.dart';
import 'package:meal_deal_app/feature/home/widgets/products_card_widget.dart';
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

  String selectedValue = '';
  String selectedValueButton = 'Listing';

  static final List<Map<String, dynamic>> _bottomButton = [
    {"title": "Listing", "icon": Assets.icons.listing.path},
    {"title": "Map View", "icon": Assets.icons.mapView.path},
  ];


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
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
          CustomContainer(
            paddingVertical: 8.h,
            radiusAll: 8.w,
            verticalMargin: 10.h,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                offset: Offset(2, 3),
                blurRadius: 5,
              ),
            ],
            width: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Row(
                  children: HelperData.categoryItem.map((item) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomContainer(
                          onTap: () {
                            selectedValue = item["title"];
                            setState(() {});
                          },
                          horizontalMargin: 4.w,
                          paddingVertical: 4.h,
                          paddingHorizontal: 10.w,
                          color: selectedValue == item["title"]
                              ? AppColors.primaryColor
                              : Colors.white,
                          radiusAll: 4.w,
                          child: CustomText(
                            text: item["title"],
                            color: selectedValue == item["title"]
                                ? Colors.white
                                : AppColors.black400TextColor,
                          ),
                        ),
                        if (selectedValue == item["title"])
                          GestureDetector(
                            onTapDown: (details) {
                              MenuShowHelper.showCustomMenu(
                                context: context,
                                details: details,
                                options: List<String>.from(item["items"]),
                              );
                            },
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        SizedBox(
                          height: 26.h,
                          width: 24.w,
                          child: VerticalDivider(color: AppColors.borderColor),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 166 / 265,
              ),
              itemCount: HelperData.products.length,
              itemBuilder: (context, index) {
                final data = HelperData.products[index];
                return ProductsCardWidget(item: data);
              },
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
}
