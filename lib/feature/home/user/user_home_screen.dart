import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/feature/home/widgets/cooks_card_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import '../../../app/utils/app_colors.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';
import '../widgets/category_card_widget.dart';
import '../widgets/products_card_widget.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

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
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined,color: AppColors.primaryColor,)),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
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


            LabelTitleWidget(title: 'Browse by Cuisines',onTap: (){
              Get.toNamed(AppRoutes.categoryScreen);
            }),

            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: HelperData.category.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                  final data = HelperData.category[index];
                  return CategoryCardWidget(data: data,index: index);
                }),
              ),

            SizedBox(height: 10.h),
            Divider(color: AppColors.borderColor,thickness: 0.5,),

            LabelTitleWidget(title: 'Your previous orders',onTap: (){}),

            SizedBox(
              height: 265.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HelperData.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = HelperData.products[index];
                  return ProductsCardWidget(item: item, index: index,);
              },),
            ),



            SizedBox(height: 10.h),
            Divider(color: AppColors.borderColor,thickness: 0.5,),

            LabelTitleWidget(title: 'Top Rated Cooks',onTap: (){}),

            SizedBox(
              height: 210.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HelperData.restaurants.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = HelperData.restaurants[index];
                  return CooksCardWidget(item: item, index: index,);
              },),
            ),


            SizedBox(height: 10.h),
            Divider(color: AppColors.borderColor,thickness: 0.5,),

            LabelTitleWidget(title: 'Popular Meals',onTap: (){}),

            SizedBox(
              height: 265.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: HelperData.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = HelperData.products[index];
                  return ProductsCardWidget(item: item, index: index,);
              },),
            ),

            SizedBox(height: 24.h),

          ],
        ),
      ),
    );
  }
}


