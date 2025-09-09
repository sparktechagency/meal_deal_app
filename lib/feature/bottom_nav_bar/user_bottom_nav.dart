import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/feature/home/user/user_home_screen.dart';
import '../../app/utils/app_colors.dart';
import '../../custom_assets/assets.gen.dart';
import '../../widgets/widgets.dart';
import '../bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';

class UserBottomNav extends StatefulWidget {
  const UserBottomNav({super.key});

  @override
  State<UserBottomNav> createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> {
  final CustomBottomNavBarController _navBarController = Get.find<CustomBottomNavBarController>();
 


  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screens =  [
    UserHomeScreen(),
    UserHomeScreen(),
    UserHomeScreen(),
    UserHomeScreen(),
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
            //color: isSelected ? AppColors.primaryColor : AppColors.black700TextColor,
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
    {"icon": Assets.icons.offer.path, "label": "Offer"},
    {"icon": Assets.icons.profile.path, "label": "Profile"},
  ];

  final List<Map<String, dynamic>> _navItemsF = [
    {"icon": Assets.icons.homeF.path, "label": "Home"},
    {"icon": Assets.icons.orderF.path, "label": "Order"},
    {"icon": Assets.icons.offerF.path, "label": "Offer"},
    {"icon": Assets.icons.profileF.path, "label": "Profile"},
  ];
}
