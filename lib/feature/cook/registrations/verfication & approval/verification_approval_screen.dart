import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class VerificationApprovalScreen extends StatefulWidget {
  const VerificationApprovalScreen({super.key});

  @override
  State<VerificationApprovalScreen> createState() => _VerificationApprovalScreenState();
}

class _VerificationApprovalScreenState extends State<VerificationApprovalScreen> {

  final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CookRegistrationsController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Verification & Approval",
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkColor,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: "Get verified for unlimited dish uploads & sales",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  SizedBox(height: 30.h),
                  Form(
                    key: _globalKey,
                    child: CustomTextField(
                      controller: _registrationsController.businessController,
                      hintText: "Business Number",
                      contentPaddingHorizontal: 16.w,
                      contentPaddingVertical: 16.h,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildIdUploadSection(),
                  SizedBox(height: 20.h),
                  _buildSelfieVideoSection(),
                  SizedBox(height: 40.h),
                  GetBuilder<CookRegistrationsController>(
                      builder: (controller) {
                        return CustomButton(
                          backgroundColor: controller.isLoadingVerification
                              ? AppColors.appGreyColor
                              : null,
                          onPressed: controller.isLoadingVerification
                              ? null
                              : (){
                            if (!_globalKey.currentState!.validate()) return;
                            controller.verification();
                          },
                          label: controller.isLoadingVerification
                              ? "Loading..."
                              : "Continue",
                        );
                      }
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Widget _buildIdUploadSection() {
    return GetBuilder<CookRegistrationsController>(
        builder: (controller) {
          return _UploadSection(
            title: "Upload valid ID",
            subtitle: "(passport, national ID, or residence permit)",
            options: CookRegistrationsController.idOptions,
            groupValue: controller.idType,
            onChanged: (val) {
              controller.idType = val ?? 'passport';
              controller.update();
            },
            file: controller.selectedIdDocument,
            isVideo: false,
            onTap: () => _showMediaPickerForId(Get.context!),
            onRemove: () {
              controller.selectedIdDocument = null;
              controller.update();
            },
            isRequired: true,
          );
        }
    );
  }

  Widget _buildSelfieVideoSection() {
    return GetBuilder<CookRegistrationsController>(
        builder: (controller) {
          return _UploadSection(
            title: "Upload selfie or video ID",
            subtitle: "Share your introduction",
            options: CookRegistrationsController.selfieOptions,
            groupValue: controller.selfieVideoType,
            onChanged: (val) {
              controller.selfieVideoType = val ?? 'selfie';
              controller.update();
            },
            file: controller.selectedSelfieOrVideo,
            isVideo: controller.selfieVideoType == 'video',
            onTap: () => _showMediaPickerForSelfie(Get.context!),
            onRemove: () {
              controller.selectedSelfieOrVideo = null;
              controller.update();
            },
            isRequired: false,
          );
        }
    );
  }

  // Separate method for ID document upload
  void _showMediaPickerForId(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => GetBuilder<CookRegistrationsController>(
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Choose Image Source',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 20.h),
                    ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                        color: Color(0xFFE67E22),
                      ),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.captureIdDocument(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: Color(0xFFE67E22),
                      ),
                      title: Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.captureIdDocument(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  // Separate method for selfie/video upload
  void _showMediaPickerForSelfie(BuildContext context) {
    final controller = Get.find<CookRegistrationsController>();
    final isVideo = controller.selfieVideoType == 'video';

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => GetBuilder<CookRegistrationsController>(
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Choose ${isVideo ? 'Video' : 'Image'} Source',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 20.h),
                    ListTile(
                      leading: Icon(
                        isVideo ? Icons.videocam : Icons.photo_camera,
                        color: Color(0xFFE67E22),
                      ),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.captureSelfieOrVideo(ImageSource.camera, isVideo);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        isVideo ? Icons.video_library : Icons.photo_library,
                        color: Color(0xFFE67E22),
                      ),
                      title: Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.captureSelfieOrVideo(ImageSource.gallery, isVideo);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

class _UploadSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map<String, String> options;
  final String groupValue;
  final Function(String?) onChanged;
  final File? file;
  final bool isVideo;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool isRequired;

  const _UploadSection({
    required this.title,
    required this.subtitle,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.file,
    required this.isVideo,
    required this.onTap,
    required this.onRemove,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 20.h),
          _buildRadioRow(),
          SizedBox(height: 20.h),
          _UploadCard(
            icon: isVideo ? Icons.play_circle_outline : Icons.camera_alt_outlined,
            label: options[groupValue] ?? "",
            file: file,
            isVideo: isVideo,
            onTap: onTap,
            onRemove: onRemove,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkColor,
            ),
            if (!isRequired) ...[
              SizedBox(width: 8.w),
              CustomText(
                text: "(Optional)",
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ]
          ],
        ),
        SizedBox(height: 4.h),
        CustomText(
          text: subtitle,
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildRadioRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.entries.map((entry) {
        return Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: entry.key,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Expanded(
                child: CustomText(
                  textAlign: TextAlign.start,
                  text: entry.value,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _UploadCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final File? file;
  final bool isVideo;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _UploadCard({
    required this.icon,
    required this.label,
    required this.file,
    required this.isVideo,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isUploaded = file != null;

    return InkWell(
      onTap: isUploaded ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 140.h,
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isUploaded ? Colors.green[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isUploaded ? Colors.green : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isUploaded) _buildEmptyState(),
            if (isUploaded && !isVideo) _buildImagePreview(),
            if (isUploaded && isVideo) _buildVideoState(),
            if (isUploaded) _buildRemoveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Icon(icon, size: 24.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          color: Colors.grey[700],
          maxline: 2,
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(file!, fit: BoxFit.cover, width: double.infinity),
      ),
    );
  }

  Widget _buildVideoState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 24.sp, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        CustomText(
          text: "Uploaded",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildRemoveButton() {
    return Positioned(
      top: 8.w,
      right: 8.w,
      child: InkWell(
        onTap: onRemove,
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 14.sp, color: Colors.white),
        ),
      ),
    );
  }
}