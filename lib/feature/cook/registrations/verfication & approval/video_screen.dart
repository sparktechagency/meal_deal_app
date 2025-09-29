import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:video_player/video_player.dart';  // Import video_player

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller with the video URL (converted to Uri)
    _controller = VideoPlayerController.network(
        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4'
    )

      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // Dispose of the controller when the screen is destroyed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Video",
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Video/Illustration Section
          Container(
            height: 280.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Video player widget to show the video
                _controller.value.isInitialized
                    ? GestureDetector(
                  onTap: () {
                    // Toggle play/pause when tapping the video
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
                    : Center(child: CircularProgressIndicator()),

                // Play Button Overlay
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Color(0xFFE67E22),
                    size: 32.sp,
                  ),
                ),

                // Timer Display
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CustomText(
                      text: "00:00 / 10:20",
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Mastering Kitchen Hygiene",
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkColor,
                        textAlign: TextAlign.left,
                      ),
                      CustomText(
                        text: "Total 10 Videos",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
