import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/models/cooks/hygiene_course_model_data.dart';
import 'package:meal_deal_app/widgets/custom_button.dart';
import 'package:meal_deal_app/widgets/custom_tost_message.dart';
import 'package:story_view/story_view.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final List<HygieneCoursesModelData> videoCourses = Get.arguments ?? [];
  final StoryController _storyController = StoryController();

  void _showCannotSkipMessage() {
    showToast('Please watch the complete video to continue');
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [];

    for (var course in videoCourses) {
      if (course.fileUrl != null && course.fileUrl!.isNotEmpty) {
        storyItems.add(
          StoryItem.pageVideo(
            course.fileUrl!,
            controller: _storyController,
            caption: Text(
              course.title ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    if (storyItems.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                color: Colors.white,
                size: 64.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'No videos available',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                onPressed: () => Get.back(),
                label:
                  'Go Back',

              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Story View
          StoryView(
            storyItems: storyItems,
            controller: _storyController,
            onComplete: ()async {
             final bool success = await Get.find<AuthController>().trackMe(type:'course-video',user: true);
             if(success){
             }
              Get.back();
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Get.back();
              }
            },
            repeat: false,
          ),

          // Transparent overlay to intercept taps
          Positioned.fill(
            child: Row(
              children: [
                // Left third - block skip
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _showCannotSkipMessage();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                // Middle third - pause/play
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (_storyController.playbackNotifier.value == PlaybackState.pause) {
                        _storyController.play();
                      } else {
                        _storyController.pause();
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                // Right third - block skip
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _showCannotSkipMessage();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Close button (top right)
          Positioned(
            top: 70.h,
            right: 16.w,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Assets.icons.cleanIcon.svg(
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              tooltip: 'Close',
            ),
          ),
        ],
      ),
    );
  }
}