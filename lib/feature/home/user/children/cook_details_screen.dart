import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_deal_app/custom_assets/fonts.gen.dart';
import 'package:meal_deal_app/feature/home/widgets/feed_back_bottom_sheet_widget.dart';
import 'package:rating_summary/rating_summary.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class CookDetailsScreen extends StatelessWidget {
  const CookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomContainer(
                        height: 370.h,
                        width: double.infinity,
                        child: Assets.images.cookImage.image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      SizedBox(height: 60.h),


                      Padding(
                        padding:  EdgeInsets.all(24.r),
                        child: CustomButton(onPressed: (){
                          Get.bottomSheet(
                            FeedbackBottomSheet(),
                            isScrollControlled: false,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                            ),
                          );

                        },label: 'Write a review',fontSize: 16.sp,),
                      ),

                      CustomContainer(
                        horizontalMargin: 24.w,
                        verticalMargin: 16.h,
                        radiusAll: 8.r,
                        paddingAll: 10.r,
                        elevation: true,
                        width: double.infinity,
                        color: Colors.white,
                        child: RatingSummary(
                          thickness: 6,
                          averageStyle: TextStyle(
                              fontSize: 32.sp,
                              fontFamily: FontFamily.lora
                          ),
                          starColor: Color(0xffFFCC00),
                          color: Color(0xffFFCC00),
                          counter: 13,
                          average: 3.846,
                          showAverage: true,
                          counterFiveStars: 5,
                          counterFourStars: 4,
                          counterThreeStars: 2,
                          counterTwoStars: 1,
                          counterOneStars: 1,
                        ),
                      ),

                      CustomContainer(
                        horizontalMargin: 24.w,
                        radiusAll: 8.r,
                        paddingAll: 10.r,
                        elevation: true,
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Open hours',
                              fontSize: 16.sp,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomText(
                                    top: 6.h,
                                    text: 'Monday - Friday\nSaturday & Sunday',
                                    color: AppColors.colorA0A0A0,
                                    fontSize: 12.sp,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Flexible(
                                  child: CustomText(
                                    top: 6.h,
                                    text: '6:00 - 19:30\n9:00 - 17:00',
                                    fontSize: 12.sp,
                                    color: AppColors.colorA0A0A0,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


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
                              text: 'Address detail',
                              fontSize: 16.sp,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              text: '1.3 km   •  24 mins',
                              fontSize: 12.sp,
                              color: AppColors.colorA0A0A0,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              text: '711-2880 Nulla St, Frederick Nebraska 20620',
                              fontSize: 12.sp,
                              textAlign: TextAlign.start,
                            ),

                            SizedBox(height: 12.h),

                            // Map Section
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: SizedBox(
                                height: 150.h,
                                width: double.infinity,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(41.4339, -96.4981),
                                    zoom: 14,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId("selected-location"),
                                      position: LatLng(41.4339, -96.4981),
                                    ),
                                  },
                                  zoomControlsEnabled: false,
                                  myLocationButtonEnabled: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

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
            ),
            _buildAppBar(),
          ]),
    );
  }



  /// Profile Header Card
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
              Flexible(child: CustomText(text: " 4.5 (232)   •   13 km")),
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

  /// Transparent App Bar
  Widget _buildAppBar() {
    return Positioned(
      top: 0.h,
      left: 0.w,
      right: 0.w,
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {
          }, icon: Assets.icons.love.svg())
        ],
      ),
    );
  }
}





