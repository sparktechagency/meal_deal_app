import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/custom_assets/fonts.gen.dart';

import '../app/utils/app_colors.dart';
import '../custom_assets/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleSize = 16,
    this.centerTitle = true,
    this.titleWidget,
    this.flexibleSpace,
    this.showLeading = true,
    this.actions,
    this.backAction,
    this.leading,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.toolbarHeight,
  });

  final String? title;
  final double titleSize;
  final bool centerTitle;
  final Widget? titleWidget;
  final Widget? flexibleSpace;
  final bool showLeading;
  final Color? borderColor;
  final double? borderWidth;
  final List<Widget>? actions;
  final VoidCallback? backAction;
  final Widget? leading;
  final Color? backgroundColor;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    return AppBar(
      toolbarHeight: toolbarHeight,
      titleSpacing: 0,
      shape: borderColor != null
          ? Border(
        bottom: BorderSide(color: borderColor ?? AppColors.secondaryColor , width: borderWidth ?? 1),
      )
          : null,
      centerTitle: centerTitle,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Color(0xffF5F5F7),
      foregroundColor: Colors.white,
      scrolledUnderElevation: 0,
      flexibleSpace: flexibleSpace,
      leading: leading ??
          ((showLeading && (parentRoute?.canPop ?? false))
              ? IconButton(
            icon: Assets.icons.backButton.svg(height: 32.h,width: 32.w),
            onPressed: backAction ?? () => Navigator.pop(context),
          )
              : null),
      title: title != null && title!.isNotEmpty
          ? Text(
        title!,
        style: TextStyle(
          fontFamily: FontFamily.lora,
          fontWeight: FontWeight.w400,
          fontSize: titleSize.sp,
          color: AppColors.appBarTitleColor,
        ),
      )
          : titleWidget,
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(toolbarHeight ?? 60);
}
