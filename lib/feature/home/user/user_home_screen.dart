import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import '../../../app/utils/app_colors.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

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


            LabelTitleWidget(title: 'Browse by Cuisines'),

            SizedBox(
              height: 180.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(HelperData.category.length, (index) {
                    final data = HelperData.category[index];
                    return CustomContainer(
                      paddingHorizontal: 10.w,
                      marginRight: 14.w,
                      marginLeft: index == 0 ? 14.w : 0,
                      radiusAll: 8.r,
                      height: 105.h,
                      width: 75.w,
                      color: AppColors.bgColor,
                      bordersColor: AppColors.borderColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 75.h,
                            width: 75.w,
                            child: data['image'],
                          ),
                          FittedBox(child: CustomText(text: data['title'],fontSize: 12.sp)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),

            CustomText(
                top: 24.h,
                bottom: 10.h,
                left: 16.w,
                right: 16.w,
                text: 'Upcoming Sessions',fontWeight: FontWeight.w600,fontSize: 16.sp),



            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 6.h),
                child: CustomListTile(
                  contentPaddingVertical: 6.h,
                  borderRadius: 8.r,
                  borderColor: AppColors.borderColor,
                  image: '',
                  title: 'Annette Black',
                  subTitle: '08/08/25 at 4:30 PM',
                  titleFontSize: 16.sp,
                  trailing: CustomButton(
                    radius: 8.r,
                    height: 25.h,
                    fontSize: 10.sp,
                      onPressed: (){},label: 'View Detail'),
                ),
              );
            },),

            SizedBox(height: 44.h),

          ],
        ),
      ),
    );
  }
}
