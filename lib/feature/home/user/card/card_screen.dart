import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../widgets/widgets.dart';



class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {


  double get totalPrice => HelperData.cartItems.fold(
      0, (sum, item) => sum + (item.price * item.quantity));

  int get totalQuantity =>
      HelperData.cartItems.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: const CustomAppBar(
        title: 'Cart',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            left: 16.w,
            bottom: 10.h,
            text: 'Your items',
            color: AppColors.black800TextColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: HelperData.cartItems.length,
              itemBuilder: (context, index) {
                return _menuCardWidget(HelperData.cartItems[index], index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: CustomContainer(
          onTap: (){
            Get.toNamed(AppRoutes.checkoutScreen);
          },
          marginAll: 16.r,
          paddingAll: 8.r,
          color: AppColors.primaryColor,
          radiusAll: 8.r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainer(
                bordersColor: Colors.white,
                shape: BoxShape.circle,
                paddingAll: 8.r,
                child: CustomText(
                  text: totalQuantity.toString(),
                  color: Colors.white,
                ),
              ),
              Flexible(
                child: CustomText(
                  text: 'Checkout',
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              Flexible(
                child: CustomText(
                  text: '\$ ${totalPrice.toStringAsFixed(2)}',
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCardWidget(CartItem item, int index) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: item.name,
                        fontSize: 16.sp,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          HelperData.cartItems.removeAt(index);
                        });
                      },
                      child: Assets.icons.delete.svg(),
                    ),
                  ],
                ),
                CustomText(
                  text: "\$${item.price}",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  top: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: 'Cook : ${item.cookName}',
                        fontSize: 12.sp,
                        color: AppColors.colorA0A0A0,
                      ),
                    ),
                    CustomContainer(
                      paddingHorizontal: 4.w,
                      height: 34.h,
                      width: 90.w,
                      bordersColor: AppColors.primaryColor,
                      radiusAll: 8.r,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (item.quantity > 1) item.quantity--;
                              });
                            },
                            child: Icon(Icons.remove, size: 16.r),
                          ),
                          CustomText(
                            text: "${item.quantity}",
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item.quantity++;
                              });
                            },
                            child: Icon(Icons.add, size: 16.r),
                          ),
                        ],
                      ),
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
