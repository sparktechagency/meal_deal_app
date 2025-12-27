import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/widgets/cooks_card_widget.dart';
import 'package:meal_deal_app/feature/home/widgets/products_card_widget.dart';
import '../../widgets/widgets.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {


  String selectedValue = 'meals';


  final buttons = [
    {'label' : 'Meals', 'value' : 'meals'},
    {'label' : 'Cooks', 'value' : 'cooks'},
  ];


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Favourite'),
      body: Column(
        children: [
          TwoButtonWidget(
            bgColor: AppColors.white1TextColor,
              buttons: buttons, selectedValue: selectedValue, onTap: (value){
            selectedValue = value;
            setState(() {});
          }),


          SizedBox(height: 20.h),
          if(selectedValue == 'meals')
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 166 / 265,
              ),
              itemCount: HelperData.products.length,
              itemBuilder: (context, index) {
                final data = HelperData.products[index];
                return ProductsCardWidget(
                  mealsId: '',
                );
              },
            ),
          ),

          if(selectedValue == 'cooks')
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 160 / 210,
                ),
                itemCount: HelperData.restaurants.length,
                itemBuilder: (context, index) {
                  final data = HelperData.restaurants[index];
                  return CooksCardWidget(cookID: '',);
                },
              ),
            ),

        ],
      ),
    );
  }

}
