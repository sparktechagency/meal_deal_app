import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class CookHomeScreen extends StatefulWidget {
  const CookHomeScreen({super.key});

  @override
  State<CookHomeScreen> createState() => _CookHomeScreenState();
}

class _CookHomeScreenState extends State<CookHomeScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        titleWidget: CustomListTile(
          imageRadius: 18.r,
          contentPaddingHorizontal: 16.w,
          titleColor: AppColors.black600TextColor,
          title: 'Hi Serah!',
          titleFontSize: 15.sp,
          subTitle: 'Having a busy day? Let us take care of your meal.',
          statusColor: AppColors.black800TextColor,
        ),
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.notifications_none_outlined,color: AppColors.primaryColor,)),
        ],
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTextField(
              prefixIcon: Icon(Icons.search,color: AppColors.appGreyColor,),
              hintText: 'What would you like to order today?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.black500TextColor)
              ),
              validator: (_) => null,
                controller: _searchController),
          ),


          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: CategoryItemWidget(
              selectedValue: 'New',
              categoryItem: HelperData.categoryItemCook,
              showChildCategory: false,
            ),
          ),


          LabelTitleWidget(
            isSeeShow: false,
              title: 'Your Today’s Orders'),

          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                return _menuCardWidget();
              }),
          ),



        ],
      ),
    );
  }

  Widget _menuCardWidget() {
    return CustomContainer(
      onTap: () {},
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 5,
        ),
      ],
      verticalMargin: 6.h,
      horizontalMargin: 16.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.img.image(
            width: 70.w,
            height: 70.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Homemade Chicken Biryani',
                  fontSize: 16.sp,
                ),
                CustomText(
                  text: "3 Persons",
                  color: AppColors.black300TextColor,
                  fontSize: 12.sp,
                  top: 2.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: CustomText(
                              text: "Today",
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: CustomText(
                              text: "4PM-5PM",
                              fontSize: 10.sp,
                              color: AppColors.black300TextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      height: 22.h,
                      width: 60.w,
                      bordersColor: AppColors.primaryColor,
                      radiusAll: 4.r,
                      alignment: Alignment.center,
                      child: CustomText(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          text: 'Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


