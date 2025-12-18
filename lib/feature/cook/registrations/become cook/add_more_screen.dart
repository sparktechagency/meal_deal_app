import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/menu_show_helper.dart';
import 'package:meal_deal_app/app/helpers/photo_picker_helper.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class AddMoreScreen extends StatefulWidget {
  const AddMoreScreen({super.key});

  @override
  State<AddMoreScreen> createState() => _AddMoreScreenState();
}

class _AddMoreScreenState extends State<AddMoreScreen> {
  final controller = Get.find<AddMealController>();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        appBar: CustomAppBar(
          title: "Add More",
          centerTitle: true,
        ),
        body: GetBuilder<AddMealController>(
          builder: (ctrl) => SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  // Image Section with Validation
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Photos/Videos",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: AppColors.darkColor,
                        bottom: 8.h,
                      ),
                      SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          itemCount: (ctrl.images?.length ?? 0) + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            // Add Photo Button (First Item)
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  PhotoPickerHelper.showPicker(
                                    context: context,
                                    onImagePicked: (file) {
                                      ctrl.images ??= [];
                                      ctrl.images!.add(File(file.path));
                                      ctrl.update();
                                    },
                                  );
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
                              );
                            }

                            // Image Preview Items
                            return _buildImagePreview(
                              ctrl.images![index - 1],
                              onDelete: () {
                                ctrl.images!.removeAt(index - 1);
                                ctrl.update();
                              },
                            );
                          },
                        ),
                      ),
                      // Image validation error
                      if ((ctrl.images?.isEmpty ?? true))
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: CustomText(
                            text: "Please add at least one photo",
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(height: 16.h),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Meal Name
                  _buildFormField(
                    label: "Meal Name",
                    hint: "e.g.",
                    controller: ctrl.mealNameController,
                  ),

                  // Description
                  _buildFormField(
                    label: "Description",
                    hint: "Describe your meal in detail",
                    controller: ctrl.descriptionController,
                    maxLines: 3,
                  ),

                  // Available Portion
                  _buildFormField(
                    label: "Available Portion",
                    hint: "e.g.",
                    controller: ctrl.portionController,
                  ),

                  // Category Type Dropdown (Dietary)
                  _buildDynamicDropdownField(
                    label: "Dietary categories",
                    hint: "Select dietary categories",
                    items: ctrl.getCategoryNamesByType('dietary'),
                    value: ctrl.selectedCategoryDietary,
                    onChanged: (value) {
                      ctrl.updateSelectedDietary(value);
                    },
                  ),
                  // Filtered Category Dropdown (Meal Type)
                  _buildDynamicDropdownField(
                    label: "Category",
                    hint: "Select category option",
                    items: ctrl.getCategoryNamesByType('meal'),
                    value: ctrl.selectedCategory,
                    onChanged: (value) {
                      ctrl.updateSelectedCategory(value);
                    },
                  ),
                  // Fitness Flow (Dynamic from API)
                  _buildDynamicDropdownField(
                    label: "Fitness Flow",
                    hint: "Select fitness option",
                    items: ctrl.getCategoryNamesByType('fitness'),
                    value: ctrl.selectedFitness,
                    onChanged: (value) {
                      ctrl.updateSelectedFitness(value);
                    },
                  ),

                  // Cheat Flow (Dynamic from API)
                  _buildDynamicDropdownField(
                    label: "Cheat Flow",
                    hint: "Select cheat option",
                    items: ctrl.getCategoryNamesByType('cheat'),
                    value: ctrl.selectedCheat,
                    onChanged: (value) {
                      ctrl.updateSelectedCheat(value);
                    },
                  ),

                  // Time for Order (WITH TIME PICKER)
                  _buildTimePickerField(
                    label: "Time for Order",
                    hint: "Select time",
                    controller: ctrl.timeOrderController,
                    context: context,
                  ),

                  // Time for Pick Up Food (WITH TIME PICKER)
                  _buildTimePickerField(
                    label: "Time for Pick Up Food",
                    hint: "Select time",
                    controller: ctrl.pickUpTimeController,
                    context: context,
                  ),

                  // Price Per Portion
                  _buildFormField(
                    label: "Price Per Portion",
                    hint: "e.g.",
                    controller: ctrl.priceController,
                  ),

                  // Served Warm
                  _buildDynamicDropdownField(
                    label: "Served Warm 🔥",
                    hint: "Select option",
                    items: ['Warm', 'Cold'],
                    value: ctrl.selectedWarmOption,
                    onChanged: (value) {
                      ctrl.updateSelectedWarmOption(value);
                    },
                  ),

                  // Cold, to be reheated
                  _buildFormField(
                    validator: (_) => null,
                    label: "Cold, to be reheated (Optional)",
                    hint: "e.g.",
                    controller: ctrl.reheatedController,
                  ),

                  // Ingredients
                  _buildFormField(
                    label: "Ingredients",
                    hint: "e.g.",
                    controller: ctrl.ingredientsController,
                    maxLines: 2,
                  ),

                  // Allergy Information
                  _buildFormField(
                    label: "Allergy Information",
                    hint: "e.g.",
                    controller: ctrl.allergyController,
                    maxLines: 2,
                  ),

                  // Location
                  _buildLocationField(
                    label: "Location",
                    hint: "e.g.",
                    controller: ctrl.locationController,
                  ),

                  // Pick Up Time
                  _buildFormField(
                    label: "Pick Up Time",
                    hint: "minutes",
                    controller: ctrl.pickupMinutesController,
                  ),

                  // Offer
                  _buildFormField(
                    validator: (_) => null,
                    label: "Offer (Optional)",
                    hint: "10% Off 1st Time Request",
                    controller: ctrl.offerController,
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
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
          child: SafeArea(
            child: GetBuilder<AddMealController>(
              builder: (ctrl) => CustomButton(
                backgroundColor: ctrl.isLoadingAddMeal ? AppColors.appGreyColor : null,
                onPressed: () {
                  if (!_globalKey.currentState!.validate()) return;
                  controller.becomeCook();
                },
                label: ctrl.isLoadingAddMeal ? "Saving..." : "Save",
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Category Type Dropdown using CustomMenu with Validation
  Widget _buildDynamicDropdownField({
    required String label,
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
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
        GestureDetector(
          onTapDown: (TapDownDetails details) async {
            final selected = await MenuShowHelper.showCustomMenu(
              context: context,
              details: details,
              options: items,
            );
            if (selected != null) {
              onChanged(selected);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color:  Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value ?? hint,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: value != null ? Colors.black : Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        // Show error if not selected
        if (value == null)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CustomText(
              left: 18.w,
              text: "Please select $label",
              fontSize: 12.sp,
              color: AppColors.errorColor,
            ),
          ),
        SizedBox(height: 16.h),
      ],
    );
  }

  /// Time Picker Field Widget with Validation
  Widget _buildTimePickerField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required BuildContext context,
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
        InkWell(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              final formattedTime = pickedTime.format(context);
              controller.text = formattedTime;
              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color:  Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text.isEmpty ? hint : controller.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: controller.text.isEmpty
                        ? Colors.grey[600]
                        : Colors.black,
                  ),
                ),
                Icon(
                  Icons.access_time,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        // Show error if empty
        if (controller.text.isEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: CustomText(
              text: "Please select $label",
              fontSize: 12.sp,
              color: AppColors.errorColor,
            ),
          ),
        SizedBox(height: 16.h),
      ],
    );
  }

  /// Image Preview Widget with Delete Function
  Widget _buildImagePreview(File image, {required Function() onDelete}) {
    return Container(
      width: 120.w,
      height: 120.h,
      margin: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.h,
            right: 8.w,
            child: InkWell(
              onTap: onDelete,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                    ),
                  ],
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

  /// Form Field Widget
  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    FormFieldValidator? validator,
    int maxLines = 1,
  }) {
    return CustomTextField(
      labelText: label,
      controller: controller,
      hintText: hint,
      maxLines: maxLines,
      minLines: maxLines,
      contentPaddingHorizontal: 16.w,
      contentPaddingVertical: 12.h,
      validator: validator ?? (value) {
        if (value?.isEmpty ?? true) {
          return "$label is required";
        }
        return null;
      },
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      filColor: Colors.white,
    );
  }

  /// Location Field Widget
  Widget _buildLocationField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return CustomTextField(
      labelText: label,
      controller: controller,
      hintText: hint,
      contentPaddingHorizontal: 16.w,
      contentPaddingVertical: 12.h,
      suffixIcon: Icon(Icons.location_on_outlined,
          color: Colors.grey[600], size: 20.sp),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "$label is required";
        }
        return null;
      },
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      filColor: Colors.white,
    );
  }
}