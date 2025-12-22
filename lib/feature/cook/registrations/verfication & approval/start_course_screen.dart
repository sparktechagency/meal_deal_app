import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class StartCourseScreen extends StatefulWidget {
  const StartCourseScreen({super.key});

  @override
  State<StartCourseScreen> createState() => _StartCourseScreenState();
}

class _StartCourseScreenState extends State<StartCourseScreen> with RouteAware {
  final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();
  final UserController _userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registrationsController.hygieneCourse();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkCompletionStatus();
  }

  void _checkCompletionStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizzesCompleted = _userController.cookUseModelData?.isCookQuiz ?? false;
      if (quizzesCompleted) {
        Get.offAllNamed(AppRoutes.waitingApprovalScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: GetBuilder<CookRegistrationsController>(
          builder: (controller) {
            final videos = controller.hygieneCoursesData.where((course) => course.fileType == 'video').toList();
            final pdf = controller.hygieneCoursesData.where((course) => course.fileType == 'pdf').toList();
            final quiz = controller.hygieneCoursesData.where((course) => course.fileType == 'quiz').toList();


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                CustomText(
                  text: "Verification & Approval",
                  textAlign: TextAlign.left,
                  color: AppColors.darkColor,
                  fontSize: 20.sp,
                  bottom: 6.h,
                ),

                // Subtitle
                CustomText(
                  bottom: 6.h,
                  text: "Get verified for unlimited dish uploads & sales",
                  textAlign: TextAlign.left,
                  color: AppColors.darkColor,
                ),

                CustomText(
                  text: "Short online hygiene course (Mandatory)",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                  color: AppColors.darkColor,
                ),
                SizedBox(height: 40.h),

                // Course Options
                GetBuilder<UserController>(
                    builder: (userController) {
                      final videoCompleted = userController.cookUseModelData?.isCookVideo ?? false;
                      final pdfCompleted = userController.cookUseModelData?.isCookPdf ?? false;
                      final quizzesCompleted = userController.cookUseModelData?.isCookQuiz ?? false;

                      return Column(
                        children: [
                          _buildCourseOption(
                            title: "Video",
                            icon: Icons.play_circle_outline,
                            isCompleted: videoCompleted,
                            isEnabled: true,
                            onTap: () {
                              Get.toNamed(AppRoutes.videoScreen, arguments: videos);
                            },
                          ),

                          SizedBox(height: 16.h),

                          _buildCourseOption(
                            title: "Pdf",
                            icon: Icons.picture_as_pdf_outlined,
                            isCompleted: pdfCompleted,
                            isEnabled: videoCompleted,
                            onTap: () {
                              if (videoCompleted && pdf.isNotEmpty) {
                                Get.toNamed(AppRoutes.pdfScreen, arguments: pdf.first.fileUrl);
                              }
                            },
                          ),

                          SizedBox(height: 16.h),

                          _buildCourseOption(
                            title: "Quizzes",
                            icon: Icons.quiz_outlined,
                            isCompleted: quizzesCompleted,
                            isEnabled: videoCompleted && pdfCompleted,
                            onTap: () {
                              if (videoCompleted && pdfCompleted) {
                                Get.toNamed(
                                    AppRoutes.quizScreen,
                                    arguments: {
                                      'quizzes': quiz.first.quizzes,
                                      'quizID': quiz.first.sId
                                    }
                                )?.then((_) {
                                  _checkCompletionStatus();
                                });
                              }
                            },
                          ),
                        ],
                      );
                    }
                ),

              ],
            );
          }
      ),
    );
  }

  Widget _buildCourseOption({
    required String title,
    required IconData icon,
    required bool isCompleted,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isCompleted
                ? Colors.green
                : isEnabled
                ? Color(0xFFE67E22)
                : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w500,
              color: isEnabled ? AppColors.darkColor : Colors.grey.shade400,
            ),
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : isEnabled
                    ? Color(0xFFE67E22).withOpacity(0.1)
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check
                    : isEnabled
                    ? icon
                    : Icons.lock_outline,
                color: isCompleted
                    ? Colors.green
                    : isEnabled
                    ? Color(0xFFE67E22)
                    : Colors.grey.shade400,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}