import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VerificationApprovalScreen extends StatefulWidget {
  const VerificationApprovalScreen({super.key});

  @override
  State<VerificationApprovalScreen> createState() => _VerificationApprovalScreenState();
}

class _VerificationApprovalScreenState extends State<VerificationApprovalScreen> {
  final businessNumberController = TextEditingController();
  final _picker = ImagePicker();

  File? selectedIdDocument;
  File? selectedSelfieOrVideo;

  String idType = 'passport';
  String selfieVideoType = 'selfie';

  static const idOptions = {
    'passport': 'Passport / Resident Permit',
    'nationalId': 'National ID',
  };

  static const selfieOptions = {
    'selfie': 'Selfie',
    'video': 'Video',
  };

  @override
  void dispose() {
    businessNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickMedia({required bool isVideo}) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SafeArea(
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
                onTap: () async {
                  Navigator.pop(context);
                  await _captureMedia(ImageSource.camera, isVideo);
                },
              ),
              ListTile(
                leading: Icon(
                  isVideo ? Icons.video_library : Icons.photo_library,
                  color: Color(0xFFE67E22),
                ),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _captureMedia(ImageSource.gallery, isVideo);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureMedia(ImageSource source, bool isVideo) async {
    try {
      if (isVideo) {
        final file = await _picker.pickVideo(
          source: source,
          maxDuration: Duration(seconds: 30),
        );
        if (file != null) setState(() => selectedSelfieOrVideo = File(file.path));
      } else {
        final file = await _picker.pickImage(
          source: source,
          maxWidth: 1080,
          maxHeight: 1080,
          imageQuality: 85,
        );
        if (file != null) {
          setState(() => selfieVideoType == 'selfie'
              ? selectedSelfieOrVideo = File(file.path)
              : selectedIdDocument = File(file.path));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Widget _buildRadioRow(Map<String, String> options, String groupValue,
      Function(String?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.entries.map((entry) {
        return Expanded(
          child: Row(
            children: [
              Radio<String>(
                value: entry.key,
                groupValue: groupValue,
                onChanged: (val) {
                  onChanged(val);
                  setState(() {});
                },
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

  Widget _buildUploadSection({
    required String title,
    required String subtitle,
    required Map<String, String> options,
    required String groupValue,
    required Function(String?) onChanged,
    required File? file,
    required bool isVideo,
    required VoidCallback onTap,
    required VoidCallback onRemove,
    required bool isRequired,
  }) {
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
          SizedBox(height: 20.h),
          _buildRadioRow(options, groupValue, onChanged),
          SizedBox(height: 20.h),
          _buildUploadCard(
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

  Widget _buildUploadCard({
    required IconData icon,
    required String label,
    File? file,
    required bool isVideo,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
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
            if (!isUploaded)
              Column(
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
              )
            else if (!isVideo)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.file(file!, fit: BoxFit.cover, width: double.infinity),
                ),
              )
            else
              Column(
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
              ),
            if (isUploaded)
              Positioned(
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
              ),
          ],
        ),
      ),
    );
  }

  void _validateAndContinue() {
    if (businessNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter business number')));
      return;
    }
    if (selectedIdDocument == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please upload ID document')));
      return;
    }
    Get.toNamed(AppRoutes.hygieneCourseScreen);
  }

  @override
  Widget build(BuildContext context) {
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
              CustomTextField(
                controller: businessNumberController,
                hintText: "Business Number CHE-123.456.789",
                contentPaddingHorizontal: 16.w,
                contentPaddingVertical: 16.h,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filColor: Colors.white,
              ),
              SizedBox(height: 30.h),
              _buildUploadSection(
                title: "Upload valid ID",
                subtitle: "(passport, national ID, or residence permit)",
                options: idOptions,
                groupValue: idType,
                onChanged: (val) => idType = val ?? 'passport',
                file: selectedIdDocument,
                isVideo: false,
                onTap: () => _pickMedia(isVideo: false),
                onRemove: () => setState(() => selectedIdDocument = null),
                isRequired: true,
              ),
              SizedBox(height: 20.h),
              _buildUploadSection(
                title: "Upload selfie or video ID",
                subtitle: "Share your introduction",
                options: selfieOptions,
                groupValue: selfieVideoType,
                onChanged: (val) => selfieVideoType = val ?? 'selfie',
                file: selectedSelfieOrVideo,
                isVideo: selfieVideoType == 'video',
                onTap: () => _pickMedia(isVideo: selfieVideoType == 'video'),
                onRemove: () => setState(() => selectedSelfieOrVideo = null),
                isRequired: false,
              ),
              SizedBox(height: 40.h),
              CustomButton(
                onPressed: _validateAndContinue,
                label: "Continue",
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}