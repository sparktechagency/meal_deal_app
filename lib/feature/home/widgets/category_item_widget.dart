import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/helpers/helper_data.dart';
import '../../../app/helpers/menu_show_helper.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      paddingVertical: 8.h,
      radiusAll: 8.w,
      verticalMargin: 10.h,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.01),
          offset: Offset(2, 3),
          blurRadius: 5,
        ),
      ],
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Row(
            children: HelperData.categoryItem.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomContainer(
                    onTap: () {
                      selectedValue = item["title"];
                      setState(() {});
                    },
                    horizontalMargin: 4.w,
                    paddingVertical: 4.h,
                    paddingHorizontal: 10.w,
                    color: selectedValue == item["title"]
                        ? AppColors.primaryColor
                        : Colors.white,
                    radiusAll: 4.w,
                    child: CustomText(
                      text: item["title"],
                      color: selectedValue == item["title"]
                          ? Colors.white
                          : AppColors.black400TextColor,
                    ),
                  ),
                  if (selectedValue == item["title"])
                    GestureDetector(
                      onTapDown: (details) {
                        MenuShowHelper.showCustomMenu(
                          context: context,
                          details: details,
                          options: List<String>.from(item["items"]),
                        );
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  SizedBox(
                    height: 26.h,
                    width: 24.w,
                    child: VerticalDivider(color: AppColors.borderColor),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
