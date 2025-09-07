import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../app/helpers/helper_data.dart';
import '../app/utils/app_colors.dart';
import '../custom_assets/assets.gen.dart';
import '../routes/app_routes.dart';
import '../widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(AppRoutes.roleScreen);
            },
            child: CustomText(
              text: 'Skip',
              fontWeight: FontWeight.w500,
              color: AppColors.black300TextColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _pageController,
            itemCount: HelperData.onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final data = HelperData.onboardingData[index];
              return Column(
                children: [
                  SizedBox(height: 44.h),
                  data['image'],
                  CustomText(
                    right: 24.w,
                    left: 24.w,
                    top: 10.h,
                    text: data['title'],
                    fontSize: 20.sp,
                    color: AppColors.black600TextColor,
                  ),
                  CustomText(
                    color: AppColors.black300TextColor,
                    right: 30.w,
                    left: 30.w,
                    top: 16.h,
                    text: data['subtitle'],
                  ),
                ],
              );
            },
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 210.h,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: HelperData.onboardingData.length,
                effect: ExpandingDotsEffect(
                  dotColor: AppColors.grayShade100,
                  activeDotColor: AppColors.primaryColor,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            right: 10.w,
            bottom: 50.h,
            child: Row(
              children: [
                if(currentIndex > 0)
                TextButton(
                  onPressed: () {
                    if (currentIndex > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: CustomText(
                    text: 'Prev',
                    fontWeight: FontWeight.w500,
                    color: AppColors.black300TextColor,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (currentIndex < HelperData.onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Get.offAllNamed(AppRoutes.roleScreen);
                    }
                  },
                  child: CustomText(
                    text: currentIndex == HelperData.onboardingData.length - 1
                        ? 'Finish'
                        : 'Next',
                    fontWeight: FontWeight.w500,
                    color: AppColors.black300TextColor,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
