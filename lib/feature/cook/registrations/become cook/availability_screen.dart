import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  final List<String> weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  // State management for each service type
  Map<String, Map<String, dynamic>> deliverySchedule = {};
  Map<String, Map<String, dynamic>> pickupSchedule = {};
  Map<String, Map<String, dynamic>> dineInSchedule = {};

  @override
  void initState() {
    super.initState();
    // Initialize all days as closed
    for (String day in weekDays) {
      deliverySchedule[day] = {'isOpen': false, 'from': '09:00 AM', 'to': '05:00 PM'};
      pickupSchedule[day] = {'isOpen': false, 'from': '09:00 AM', 'to': '05:00 PM'};
      dineInSchedule[day] = {'isOpen': false, 'from': '09:00 AM', 'to': '05:00 PM'};
    }
    // Set Tuesday as open by default as shown in the image
    deliverySchedule['Tuesday']!['isOpen'] = true;
    pickupSchedule['Tuesday']!['isOpen'] = true;
    dineInSchedule['Tuesday']!['isOpen'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Become a Cook",
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      SizedBox(
                        width: 45.w,
                        height: 45.h,
                        child: CircularProgressIndicator(
                          value: 0.5,
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFE67E22),
                          ),
                          backgroundColor: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Your Availability",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.left,
                        color: AppColors.darkColor,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Next: Self Responsibility Contract",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Your Availability",
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: "All My Available time here.",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: Colors.grey[600],
                    ),

                    SizedBox(height: 24.h),

                    // Delivery Section
                    _buildServiceSection(
                      title: "Delivery",
                      schedule: deliverySchedule,
                      onToggle: (day, value) {
                        setState(() {
                          deliverySchedule[day]!['isOpen'] = value;
                        });
                      },
                      onTimeChange: (day, isFrom, time) {
                        setState(() {
                          deliverySchedule[day]![isFrom ? 'from' : 'to'] = time;
                        });
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Pick Up Section
                    _buildServiceSection(
                      title: "Pick Up",
                      schedule: pickupSchedule,
                      onToggle: (day, value) {
                        setState(() {
                          pickupSchedule[day]!['isOpen'] = value;
                        });
                      },
                      onTimeChange: (day, isFrom, time) {
                        setState(() {
                          pickupSchedule[day]![isFrom ? 'from' : 'to'] = time;
                        });
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Dine in Section
                    _buildServiceSection(
                      title: "Dine in",
                      schedule: dineInSchedule,
                      onToggle: (day, value) {
                        setState(() {
                          dineInSchedule[day]!['isOpen'] = value;
                        });
                      },
                      onTimeChange: (day, isFrom, time) {
                        setState(() {
                          dineInSchedule[day]![isFrom ? 'from' : 'to'] = time;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Next Button
          Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            child: CustomButton(
              onPressed: () {
               Get.toNamed(AppRoutes.responsibilityContractScreen);
              },
              label: "Next",


            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection({
    required String title,
    required Map<String, Map<String, dynamic>> schedule,
    required Function(String, bool) onToggle,
    required Function(String, bool, String) onTimeChange,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
            text: title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.left,
            color: AppColors.darkColor,
          ),
          SizedBox(height: 16.h),

          // Days List
          ...weekDays.map((day) {
            bool isOpen = schedule[day]!['isOpen'];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: CustomText(
                        text: day,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: isOpen ? AppColors.darkColor : Colors.grey[600],
                      ),
                    ),

                    // Toggle Switch
                    Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: isOpen,
                        onChanged: (value) => onToggle(day, value),
                        activeColor: Color(0xFFE67E22),
                        inactiveThumbColor: Colors.grey[400],
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ),

                    // Status Text
                    SizedBox(
                      width: 60.w,
                      child: CustomText(
                        text: isOpen ? "Open" : "Closed",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.right,
                        color: isOpen ? Color(0xFFE67E22) : Colors.grey[500],
                      ),
                    ),
                  ],
                ),

                // Time Selection (shown when open)
                if (isOpen) ...[
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, bottom: 12.h),
                    child: Row(
                      children: [
                        CustomText(
                          text: "From",
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                          right: 8.w,
                        ),
                        _buildTimeSelector(
                          time: schedule[day]!['from'],
                          onTap: () => _selectTime(context, (time) {
                            onTimeChange(day, true, time);
                          }),
                        ),
                        SizedBox(width: 20.w),
                        CustomText(
                          text: "To",
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                          right: 8.w,
                        ),
                        _buildTimeSelector(
                          time: schedule[day]!['to'],
                          onTap: () => _selectTime(context, (time) {
                            onTimeChange(day, false, time);
                          }),
                        ),
                      ],
                    ),
                  ),
                ],

                if (day != weekDays.last)
                  Divider(color: Colors.grey[200], height: 1),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimeSelector({
    required String time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: CustomText(
          text: time,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.darkColor,
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, Function(String) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );

    if (picked != null) {
      final String formattedTime = picked.format(context);
      onTimeSelected(formattedTime);
    }
  }
}