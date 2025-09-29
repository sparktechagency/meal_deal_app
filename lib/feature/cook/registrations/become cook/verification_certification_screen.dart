import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class VerificationCertificationScreen extends StatefulWidget {
  const VerificationCertificationScreen({super.key});

  @override
  State<VerificationCertificationScreen> createState() => _VerificationCertificationScreenState();
}

class _VerificationCertificationScreenState extends State<VerificationCertificationScreen> {
  bool? hasCertification;
  String? kitchenImagePath;
  String? selfImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Verification & Certification",
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Certification Question Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Do you have any certification related to cooking?",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 20.h),

                    // Yes/No Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              setState(() {
                                hasCertification = false;
                              });
                            },
                            label: "No",
                            backgroundColor: hasCertification == false
                                ? const Color(0xFFE67E22)
                                : Colors.white,
                            foregroundColor: hasCertification == false
                                ? Colors.white
                                : AppColors.darkColor,
                            height: 45.h,
                            radius: 8.r,
                            bordersColor: hasCertification == false
                                ? null
                                : Colors.grey[300],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              setState(() {
                                hasCertification = true;
                              });
                            },
                            label: "Yes",
                            backgroundColor: hasCertification == true
                                ? const Color(0xFFE67E22)
                                : Colors.white,
                            foregroundColor: hasCertification == true
                                ? Colors.white
                                : AppColors.darkColor,
                            height: 45.h,
                            radius: 8.r,
                            bordersColor: hasCertification == true
                                ? null
                                : Colors.grey[300],
                          ),
                        ),
                      ],
                    ),

                    // Certificate Upload Options (shown when Yes is selected)
                    if (hasCertification == true) ...[
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildUploadOption(
                              icon: Icons.camera_alt_outlined,
                              label: "Take Photo",
                              onTap: () {
                                // Handle camera
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildUploadOption(
                              icon: Icons.image_outlined,
                              label: "Upload from Gallery",
                              onTap: () {
                                // Handle gallery
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Kitchen Picture Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Upload Kitchen Picture",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 16.h),

                    // Kitchen Images Grid
                    Row(
                      children: [
                        Expanded(
                          child: _buildKitchenImageBox(
                            imagePath: 'assets/images/kitchen1.jpg', // Replace with actual image
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildKitchenImageBox(
                            imagePath: 'assets/images/kitchen2.jpg', // Replace with actual image
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Self Picture Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Upload Self Picture",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 20.h),

                    // Profile Picture Circle
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: selfImagePath == null
                          ? Icon(
                        Icons.camera_alt_outlined,
                        size: 40.sp,
                        color: Colors.grey[600],
                      )
                          : ClipOval(
                        child: Image.asset(
                          selfImagePath!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    CustomText(
                      text: "A Photo of You",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 8.h),

                    CustomText(
                      text: "Please make sure your photo\nclearly shows your face.",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      textAlign: TextAlign.center,
                      maxline: 2,
                    ),

                    SizedBox(height: 20.h),

                    // Take Photo Button
                    CustomButton(
                      onPressed: () {
                        // Handle take photo
                      },
                      label: "Take Photo",
                      backgroundColor: const Color(0xFFE67E22),
                      foregroundColor: Colors.white,
                      height: 45.h,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      radius: 8.r,
                    ),

                    SizedBox(height: 12.h),

                    // Choose from Camera Roll Button
                    CustomButton(
                      onPressed: () {
                        // Handle gallery selection
                      },
                      label: "Choose From Camera Roll",
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkColor,
                      bordersColor: Colors.grey[300],
                      height: 45.h,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      radius: 8.r,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),




            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28.sp,
              color: AppColors.darkColor,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: label,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.darkColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKitchenImageBox({
    String? imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
          image: imagePath != null
              ? DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: imagePath == null
            ? Center(
          child: Icon(
            Icons.camera_alt_outlined,
            size: 32.sp,
            color: Colors.grey[600],
          ),
        )
            : Stack(
          children: [
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16.sp,
                  color: AppColors.darkColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}