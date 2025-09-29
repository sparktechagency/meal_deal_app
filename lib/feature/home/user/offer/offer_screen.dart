import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/feature/home/widgets/offer_card_widget.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Offer',
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              prefixIcon: Icon(Icons.search,color: AppColors.appGreyColor,),
              hintText: 'What would you like to order today?',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.black500TextColor)
              ),
              validator: (_) => null,
              controller: _searchController),

          CategoryItemWidget(),

          CustomText(
            top: 8.h,
              bottom: 12.h,
              text: 'Offer',fontSize: 16.sp,color: AppColors.black600TextColor),

          Expanded(
            child: ListView.builder(
              itemCount: HelperData.dummyOffers.length,
              itemBuilder: (context, index) {
                final item = HelperData.dummyOffers[index];
              return OfferCardWidget(
                item: item,
              );
            },),
          )
        ],
      ),
    );
  }
}


