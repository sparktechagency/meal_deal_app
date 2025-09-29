import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class AddMoreScreen extends StatefulWidget {
  const AddMoreScreen({super.key});

  @override
  State<AddMoreScreen> createState() => _AddMoreScreenState();
}

class _AddMoreScreenState extends State<AddMoreScreen> {
  // Controllers
  final TextEditingController mealNameController = TextEditingController(text: "e.g., Fondue");
  final TextEditingController descriptionController = TextEditingController(text: "Description");
  final TextEditingController portionController = TextEditingController(text: "e.g., 5");
  final TextEditingController categoryController = TextEditingController(text: "e.g. Main");
  final TextEditingController fitnessController = TextEditingController(text: "e.g. Protein");
  final TextEditingController cheatController = TextEditingController(text: "e.g. Comfort");
  final TextEditingController timeOrderController = TextEditingController(text: "e.g., 9 AM - 12 PM");
  final TextEditingController pickUpTimeController = TextEditingController(text: "e.g., 6 PM - 8:30 PM");
  final TextEditingController priceController = TextEditingController(text: "e.g., \$15");
  final TextEditingController warmController = TextEditingController(text: "e.g., \$7");
  final TextEditingController reheatedController = TextEditingController(text: "e.g., \$5.50");
  final TextEditingController ingredientsController = TextEditingController(text: "e.g., Chicken, Tomatoes, Spices, Coconut Milk");
  final TextEditingController allergyController = TextEditingController(text: "e.g., Contains: Nuts, Dairy");
  final TextEditingController locationController = TextEditingController(text: "23/5, Zurich,Switzerland");
  final TextEditingController pickupMinutesController = TextEditingController(text: "30 Minutes");
  final TextEditingController offerController = TextEditingController(text: "10% Off 1st Time Request");

  final TextEditingController finalPriceController = TextEditingController(text: "\$ 12.52");

  // Dropdown states
  String? selectedCategory;
  String? selectedFitness;
  String? selectedCheat;
  String? selectedWarmOption;

  List<String> uploadedImages = [];

  @override
  void dispose() {
    // Dispose all controllers
    mealNameController.dispose();
    descriptionController.dispose();
    portionController.dispose();
    categoryController.dispose();
    fitnessController.dispose();
    cheatController.dispose();
    timeOrderController.dispose();
    pickUpTimeController.dispose();
    priceController.dispose();
    warmController.dispose();
    reheatedController.dispose();
    ingredientsController.dispose();
    allergyController.dispose();
    finalPriceController.dispose();
    locationController.dispose();
    pickupMinutesController.dispose();
    offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Add More",
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Upload Section
                    Container(
                      height: 120.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Add Photo/Video Box
                          InkWell(
                            onTap: () {
                              // Handle photo/video upload
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color(0xFFE67E22),
                                    size: 32.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: "Add Photo/Videos",
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Sample uploaded images
                          _buildImagePreview(),
                          SizedBox(width: 12.w),
                          _buildImagePreview(),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Form Fields
                    _buildFormField(
                      label: "Meal Name",
                      controller: mealNameController,
                    ),

                    _buildFormField(
                      label: "Description",
                      controller: descriptionController,
                      maxLines: 3,
                    ),

                    _buildFormField(
                      label: "Available Portion",
                      controller: portionController,
                    ),

                    _buildDropdownField(
                      label: "Dietary categories",
                      hint: "e.g. Halal",
                      items: ['Halal', 'Vegetarian', 'Vegan', 'Gluten-Free'],
                    ),

                    _buildDropdownField(
                      label: "Category",
                      hint: "e.g. Main",
                      items: ['Main', 'Appetizer', 'Dessert', 'Beverage'],
                    ),

                    _buildDropdownField(
                      label: "Fitness Flow",
                      hint: "e.g. Protein",
                      items: ['Protein', 'Low Carb', 'High Fiber', 'Keto'],
                    ),

                    _buildDropdownField(
                      label: "Cheat Flow",
                      hint: "e.g. Comfort",
                      items: ['Comfort', 'Indulgence', 'Guilty Pleasure'],
                    ),

                    _buildTimeField(
                      label: "Time for Order",
                      controller: timeOrderController,
                    ),

                    _buildTimeField(
                      label: "Time for Pick Up Food",
                      controller: pickUpTimeController,
                    ),

                    _buildFormField(
                      label: "Price Per Portion",
                      controller: priceController,
                    ),

                    _buildDropdownField(
                      label: "Served Warm 🔥",
                      hint: "e.g., \$7",
                      items: ['Yes', 'No'],
                    ),

                    _buildFormField(
                      label: "Cold, to be reheated(Optional)",
                      controller: reheatedController,
                    ),

                    _buildFormField(
                      label: "Ingredients",
                      controller: ingredientsController,
                    ),

                    _buildFormField(
                      label: "Allergy Information",
                      controller: allergyController,
                    ),
                    _buildFormField(
                      label: "Price",
                      controller: priceController,
                    ),




                    _buildLocationField(
                      label: "Location",
                      controller: locationController,
                    ),

                    _buildFormField(
                      label: "Pick Up Time",
                      controller: pickupMinutesController,
                    ),

                    _buildFormField(
                      label: "Offer   (Optional)",
                      controller: offerController,
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Delete Button
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      // Handle delete
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                // Save Button
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      // Handle save
                    },
                    label: "Save",
                    backgroundColor: Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    height: 48.h,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    radius: 8.r,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: AssetImage('assets/images/food_placeholder.jpg'), // Replace with actual image
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.h,
            right: 8.w,
            child: InkWell(
              onTap: () {
                // Handle delete image
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 16.sp,
                  color: Color(0xFFE67E22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          color: AppColors.darkColor,
          bottom: 8.h,
        ),
        CustomTextField(
          controller: controller,
          hintText: controller.text,
          maxLines: maxLines,
          minLines: maxLines,
          contentPaddingHorizontal: 16.w,
          contentPaddingVertical: 12.h,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filColor: Colors.white,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          color: AppColors.darkColor,
          bottom: 8.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: TextStyle(color: Colors.grey[600])),
              icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFFE67E22)),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  // Update selected value
                });
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          color: AppColors.darkColor,
          bottom: 8.h,
        ),
        CustomTextField(
          controller: controller,
          hintText: controller.text,
          contentPaddingHorizontal: 16.w,
          contentPaddingVertical: 12.h,
          suffixIcon: Icon(Icons.access_time, color: Colors.grey[600], size: 20.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filColor: Colors.white,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildLocationField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.left,
          color: AppColors.darkColor,
          bottom: 8.h,
        ),
        CustomTextField(
          controller: controller,
          hintText: controller.text,
          contentPaddingHorizontal: 16.w,
          contentPaddingVertical: 12.h,
          suffixIcon: Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 20.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filColor: Colors.white,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}