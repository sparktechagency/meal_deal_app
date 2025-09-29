import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/widgets.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  final TextEditingController reviewController = TextEditingController();

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top drag indicator
          Center(
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          CustomText(text:
          "Write a Review",
            fontSize: 18.sp,
          ),
          SizedBox(height: 16.h),

          // ⭐ Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  rating = index + 1.0;
                  setState(() {
                  });
                },
                icon: Icon(
                  Icons.star,
                  size: 32.sp,
                  color: index < rating ? Colors.amber : Colors.grey,
                ),
              );
            }),
          ),
          SizedBox(height: 10.h),

          // ✍️ Review field
          TextField(
            controller: reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Write your feedback here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // ✅ Submit button
          SizedBox(
            width: double.infinity,
            child: CustomButton(

                onPressed: () {
                  String review = reviewController.text;
                  double stars = rating;
                  Get.back();
                  print("Rating: $stars, Review: $review");
                },
                label: "Submit",fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}