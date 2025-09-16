import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isWarm = false;

  double tk = 12.52;
  double tkWarm = 7.69;


  @override
  Widget build(BuildContext context) {
    double totalTk = isWarm ? tk + tkWarm : tk;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 280.h,
              floating: false,
              pinned: false,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.bgColor,
              leading: IconButton(
                icon: Assets.icons.backButton.svg(height: 32.h, width: 32.w),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: CustomContainer(
                    color: Colors.white,
                    paddingAll: 6.r,
                    shape: BoxShape.circle,
                    child: Assets.icons.love.svg(height: 20.h, width: 20.w),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  bottom: false,
                  child: CustomContainer(
                    color: AppColors.bgColor,
                    image: DecorationImage(image: AssetImage(Assets.images.img.path)),
                   child: Align(
                     alignment: Alignment.bottomLeft,
                     child: Padding(
                       padding:  EdgeInsets.symmetric(horizontal: 16.w),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           CustomText(text: 'Category : Main',color: AppColors.black400TextColor,bottom: 4.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                             CustomText(text: '30 Mins for Pick Up',color: AppColors.black400TextColor,bottom: 8.h,),
                             CustomText(text: '450 kcal',color: AppColors.black400TextColor,bottom: 8.h),
                           ],)
                         ],
                       ),
                     ),
                   ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// ===============>>> title ================>>
              CustomContainer(
                elevation: true,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: CustomText(
                        textAlign: TextAlign.start,
                          text: 'Fondue', fontSize: 20.sp),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Assets.icons.star.svg(height: 14.h,width: 14.w),
                          CustomText(
                              left: 2.w,
                              text:"4.5 (233)  •",
                              fontSize: 11.sp),
                          SizedBox(width: 8.w),
                          Icon(Icons.location_on,
                              size: 14.sp, color: AppColors.black600TextColor),
                          CustomText(
                              text: '1.3 km',
                              fontSize: 11.sp),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomText(
                        top: 6.h,
                        bottom: 16.h,
                        text:
                            'A classic Swiss dish made with melted cheese, usually Gruyère and Emmental, served with bread cubes for dipping. It’s a communal dish enjoyed especially during winter.',
                        fontSize: 14.sp,
                        color: AppColors.colorA0A0A0,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),



              /// ===============>>> title ================>>
              CustomContainer(
                radiusAll: 8.r,
                horizontalMargin: 24.w,
                verticalMargin: 16.h,
                paddingAll: 10.r,
                elevation: true,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(

                      text: 'Ingredients',
                      fontSize: 14.sp,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      top: 6.h,
                      text: 'Chicken,Tomato, Spices',
                      fontSize: 16.sp,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomContainer(
                        radiusAll: 8.r,
                        paddingAll: 10.r,
                        elevation: true,
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Available Portion',
                              fontSize: 14.sp,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              top: 6.h,
                              text: '3',
                              fontSize: 16.sp,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,
                    ),
                    Expanded(
                      child: CustomContainer(
                        radiusAll: 8.r,
                        paddingAll: 10.r,
                        elevation: true,
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(

                              text: 'Offer (Optional)',
                              fontSize: 14.sp,
                              textAlign: TextAlign.start,
                            ),
                            CustomText(
                              top: 6.h,
                              text: '0% Off',
                              fontSize: 16.sp,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              /// ===============>>> title ================>>
              CustomContainer(
                radiusAll: 8.r,
                horizontalMargin: 24.w,
                verticalMargin: 16.w,
                paddingAll: 10.r,
                elevation: true,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Allergy Info',
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      top: 4.h,
                      text: 'Contains Gluten, Dairy, Nuts',
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      top: 6.h,
                      text: 'Prepared in a kitchen that handles peanuts and soy products.',
                      color: AppColors.colorA0A0A0,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),

              /// ===============>>> title ================>>

              CustomContainer(
               horizontalMargin: 24.w,
                radiusAll: 8.r,
                paddingHorizontal: 10.r,
                elevation: true,
                width: double.infinity,
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: CustomText(
                      textAlign: TextAlign.start,
                      text: 'Warm/Cold Status',color: AppColors.colorA0A0A0,
                      ),
                  subtitle: CustomText(
                      textAlign: TextAlign.start,
                      text: 'Warm     \$$tkWarm'),
                  trailing: Switch(
                    value: isWarm,
                    onChanged: (value) {
                      isWarm = value;
                      setState(() {
                      });
                    },
                  ),
                ),
              ),


              /// ===============>>> title ================>>

              CustomContainer(
                horizontalMargin: 24.w,
                verticalMargin: 16.h,
                radiusAll: 8.r,
                paddingAll: 10.r,
                elevation: true,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      color: AppColors.colorA0A0A0,
                      text: 'Time for Order',
                      fontSize: 14.sp,
                      textAlign: TextAlign.start,
                    ),
                    CustomText(
                      top: 6.h,
                      text: '9 AM - 12 PM',
                      fontSize: 12.sp,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomContainer(
          marginAll: 16.r,
          radiusAll: 8.r,
          paddingAll: 12.r,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: CustomText(text: 'Add to cart',fontSize: 16.sp,color: Colors.white)),
              //Spacer(),
              CustomText(text: '\$ $totalTk',fontSize: 16.sp,color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
