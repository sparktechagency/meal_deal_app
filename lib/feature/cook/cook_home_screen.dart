import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import 'package:meal_deal_app/widgets/menu_card_widget.dart';
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
        titleWidget: GetBuilder<UserController>(
          builder: (controller) {
            return CustomListTile(
              imageRadius: 18.r,
              image: controller.useModelData?.profileImage ?? '',
              contentPaddingHorizontal: 16.w,
              titleColor: AppColors.black600TextColor,
              title: 'Hi ${controller.useModelData?.name ?? 'N/A'}!',
              titleFontSize: 15.sp,
              statusColor: AppColors.black800TextColor,
            );
          }
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
                return MenuCardWidget();
              }),
          ),



        ],
      ),
    );
  }



}



