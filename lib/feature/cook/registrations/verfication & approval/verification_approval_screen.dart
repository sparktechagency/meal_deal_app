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
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController businessNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Track uploaded files
  File? passportImage;
  File? nationalIdImage;
  File? selfieImage;
  File? introductionVideo;

  @override
  void dispose() {
    ownerNameController.dispose();
    businessNumberController.dispose();
    super.dispose();
  }

  // Method to pick image from camera or gallery
  Future<void> _pickImage(String type) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
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
                  leading: Icon(Icons.photo_camera, color: Color(0xFFE67E22)),
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _captureImage(ImageSource.camera, type);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Color(0xFFE67E22)),
                  title: Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _captureImage(ImageSource.gallery, type);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Capture image from selected source
  Future<void> _captureImage(ImageSource source, String type) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          File imageFile = File(pickedFile.path);
          switch (type) {
            case 'passport':
              passportImage = imageFile;
              break;
            case 'nationalId':
              nationalIdImage = imageFile;
              break;
            case 'selfie':
              selfieImage = imageFile;
              break;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  // Method to pick video
  Future<void> _pickVideo() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Choose Video Source',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 20.h),
                ListTile(
                  leading: Icon(Icons.videocam, color: Color(0xFFE67E22)),
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _captureVideo(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.video_library, color: Color(0xFFE67E22)),
                  title: Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _captureVideo(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Capture video from selected source
  Future<void> _captureVideo(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: source,
        maxDuration: Duration(seconds: 30),
      );

      if (pickedFile != null) {
        setState(() {
          introductionVideo = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking video: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Title Section
              CustomText(
                text: "Verification & Approval",
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
                color: AppColors.darkColor,
              ),

              SizedBox(height: 8.h),

              CustomText(
                text: "Get verified for unlimited dish uploads & sales",
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left,
                color: Colors.grey[600],
              ),

              SizedBox(height: 30.h),

              // Owner's Name Field
              CustomTextField(
                controller: ownerNameController,
                hintText: "Owner's Name",
                contentPaddingHorizontal: 16.w,
                contentPaddingVertical: 16.h,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filColor: Colors.white,
              ),

              // Business Number Field
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

              // Upload ID Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Upload valid ID",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: "(passport, national ID, or residence permit)",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: Colors.grey[600],
                    ),

                    SizedBox(height: 20.h),

                    // Upload Options Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildUploadCard(
                            icon: Icons.camera_alt_outlined,
                            label: "Upload Passport / Resident Permit",
                            file: passportImage,
                            onTap: () => _pickImage('passport'),
                            onRemove: () {
                              setState(() {
                                passportImage = null;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildUploadCard(
                            icon: Icons.camera_alt_outlined,
                            label: "Upload National ID",
                            file: nationalIdImage,
                            onTap: () => _pickImage('nationalId'),
                            onRemove: () {
                              setState(() {
                                nationalIdImage = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Upload Selfie/Video Section
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Upload selfie or video ID",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: "(Optional)",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: Colors.grey[600],
                    ),

                    SizedBox(height: 20.h),

                    // Upload Options Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildUploadCard(
                            icon: Icons.camera_alt_outlined,
                            label: "Upload Selfie",
                            file: selfieImage,
                            onTap: () => _pickImage('selfie'),
                            onRemove: () {
                              setState(() {
                                selfieImage = null;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildUploadCard(
                            icon: Icons.play_circle_outline,
                            label: "Self Introduction Video",
                            file: introductionVideo,
                            isVideo: true,
                            onTap: () => _pickVideo(),
                            onRemove: () {
                              setState(() {
                                introductionVideo = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Continue Button
              CustomButton(
                onPressed: () {
                  // Validate and submit data
                  if (ownerNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter owner name')),
                    );
                    return;
                  }
                  if (businessNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter business number')),
                    );
                    return;
                  }
                  if (passportImage == null && nationalIdImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please upload at least one ID document')),
                    );

                  }
                  Get.toNamed(AppRoutes.hygieneCourseScreen);
                },
                label: "Continue",



              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required IconData icon,
    required String label,
    File? file,
    bool isVideo = false,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    bool isUploaded = file != null;

    return InkWell(
      onTap: isUploaded ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 140.h,
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isUploaded) ...[
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Icon(
                      icon,
                      size: 24.sp,
                      color: Colors.grey[600],
                    ),
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
                ] else ...[
                  if (!isVideo && file != null) ...[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: isVideo ? "Video Uploaded" : "Uploaded",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ],
                ],
              ],
            ),
            if (isUploaded)
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: onRemove,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}