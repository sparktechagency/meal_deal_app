import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'dart:io';

class VerificationCertificationScreen extends StatefulWidget {
  const VerificationCertificationScreen({super.key});

  @override
  State<VerificationCertificationScreen> createState() => _VerificationCertificationScreenState();
}

class _VerificationCertificationScreenState extends State<VerificationCertificationScreen> {
  bool? hasCertification;
  final ImagePicker _imagePicker = ImagePicker();
  late CookRegistrationsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<CookRegistrationsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "Verification & Certification",
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
                                _controller.certificates = null;
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

                    // Certificate Upload Options
                    if (hasCertification == true) ...[
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildUploadOption(
                              icon: Icons.camera_alt_outlined,
                              label: "Take Photo",
                              onTap: () => _pickCertificateFromCamera(),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildUploadOption(
                              icon: Icons.image_outlined,
                              label: "Upload from Gallery",
                              onTap: () => _pickCertificateFromGallery(),
                            ),
                          ),
                        ],
                      ),
                      if (_controller.certificates != null) ...[
                        SizedBox(height: 12.h),
                        CustomText(
                          text: "✓ Certificate uploaded",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ],
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

                    // Kitchen Images Preview
                    if (_controller.kitchenImages != null && _controller.kitchenImages!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Uploaded Images",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkColor,
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: _controller.kitchenImages!.map((kitchen) {
                              int index = _controller.kitchenImages!.indexOf(kitchen);
                              return Stack(
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.file(
                                        kitchen,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0.h,
                                    right: 0.h,
                                    child: GestureDetector(
                                      onTap: () => _removeKitchenImage(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(4.w),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),

                    // Kitchen Images Upload Options
                    Row(
                      children: [
                        Expanded(
                          child: _buildUploadOption(
                            icon: Icons.camera_alt_outlined,
                            label: "Take Photo",
                            onTap: () => _pickKitchenImage(ImageSource.camera),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildUploadOption(
                            icon: Icons.image_outlined,
                            label: "Upload from Gallery",
                            onTap: () => _pickKitchenImage(ImageSource.gallery),
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
                      child: _controller.profileImage == null
                          ? Icon(
                        Icons.camera_alt_outlined,
                        size: 40.sp,
                        color: Colors.grey[600],
                      )
                          : ClipOval(
                        child: Image.file(
                          _controller.profileImage!,
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
                      onPressed: () => _pickProfileImageFromCamera(),
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
                      onPressed: () => _pickProfileImageFromGallery(),
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: GetBuilder<CookRegistrationsController>(
                builder: (controller) {
                  return CustomButton(
                    onPressed: controller.isLoadingBecome ? null : () => _submitBecomeCook(),
                    label: controller.isLoadingBecome ? "Processing..." : "Submit",
                    backgroundColor: controller.isLoadingBecome ? Colors.grey : const Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Image picker functions
  Future<void> _pickCertificateFromCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _controller.certificates = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickCertificateFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller.certificates = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickKitchenImage(ImageSource source) async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _controller.kitchenImages ??= [];
      _controller.kitchenImages!.add(File(pickedFile.path));
      setState(() {});
    }
  }

  void _removeKitchenImage(int index) {
    if (_controller.kitchenImages != null && index < _controller.kitchenImages!.length) {
      _controller.kitchenImages!.removeAt(index);
      setState(() {});
    }
  }

  Future<void> _pickProfileImageFromCamera() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _controller.profileImage = File(pickedFile.path);
      setState(() {});
    }
  }

  Future<void> _pickProfileImageFromGallery() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller.profileImage = File(pickedFile.path);
      setState(() {});
    }
  }

  // Validation
  bool _validateInputs() {
    if (_controller.kitchenImages == null || _controller.kitchenImages!.isEmpty) {
      Get.snackbar('Error', 'Please upload at least one kitchen image');
      return false;
    }
    if (_controller.profileImage == null) {
      Get.snackbar('Error', 'Please upload your profile picture');
      return false;
    }
    if (hasCertification == true && _controller.certificates == null) {
      Get.snackbar('Error', 'Please upload your certification');
      return false;
    }
    return true;
  }

  // Submit API call
  Future<void> _submitBecomeCook() async {
    if (!_validateInputs()) return;
    await _controller.becomeCook();
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
}