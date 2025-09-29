import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/feature/cook/add_menu/add_menu_screen.dart';
import 'package:meal_deal_app/feature/cook/cook_home_screen.dart';
import 'package:meal_deal_app/feature/cook/order/cook_order_screen.dart';
import 'package:meal_deal_app/feature/cook/profile/profile_screen.dart';
import 'package:meal_deal_app/feature/home/user/offer/offer_screen.dart';
import 'package:meal_deal_app/feature/home/user/order/order_screen.dart';
import 'package:meal_deal_app/feature/home/user/user_home_screen.dart';
import 'package:meal_deal_app/feature/profile/profile_screen.dart';
import '../../app/utils/app_colors.dart';
import '../../custom_assets/assets.gen.dart';
import '../../widgets/widgets.dart';
import '../bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';

class CookBottomNav extends StatefulWidget {
  const CookBottomNav({super.key});

  @override
  State<CookBottomNav> createState() => _CookBottomNavState();
}

class _CookBottomNavState extends State<CookBottomNav> {
  final CustomBottomNavBarController _navBarController = Get.find<CustomBottomNavBarController>();



  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screens =  [
    CookHomeScreen(),
    CookOrderScreen(),
    AddMenuScreen(),
    CookProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: AppColors.bgColor,
      body: _screens[_navBarController.selectedIndex.value],
      bottomNavigationBar: SafeArea(
        child: CustomContainer(
          horizontalMargin: 16.w,
          verticalMargin: 6.w,
          radiusAll: 100.r,
          paddingVertical: 10.h,
          color: AppColors.bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(-2, -2),
            ),
            // Inner shadow (for the pressed-in effect)
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                _navItems.length, (index) => _buildNavItem(index)),
          ),
        ),
      ),
    ));
  }

  Widget _buildNavItem(int index) {
    bool isSelected = _navBarController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => _navBarController.onChange(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSelected ? _navItemsF[index]["icon"] : _navItems[index]["icon"],
            width: 24.w,
            height: 24.h,
          ),
          CustomText(
            top: 1.h,
            text: _navItems[index]["label"],fontSize: 12.sp,color: isSelected ? AppColors.primaryColor : AppColors.black700TextColor,)
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Assets.icons.home.path, "label": "Home"},
    {"icon": Assets.icons.order.path, "label": "Order"},
    {"icon": Assets.icons.addMenu.path, "label": "Add Menu"},
    {"icon": Assets.icons.profile.path, "label": "Profile"},
  ];

  final List<Map<String, dynamic>> _navItemsF = [
    {"icon": Assets.icons.homeF.path, "label": "Home"},
    {"icon": Assets.icons.orderF.path, "label": "Order"},
    {"icon": Assets.icons.addMenuF.path, "label": "Add Menu"},
    {"icon": Assets.icons.profileF.path, "label": "Profile"},
  ];
}
