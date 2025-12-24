import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/feature/home/widgets/cooks_card_widget.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';


class MapViewScreen extends StatefulWidget {
  const MapViewScreen({super.key});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {


  String selectedCuisine = "";
  final TextEditingController _searchController = TextEditingController();
  BitmapDescriptor? restaurantIcon;


  LatLng? currentLatLng;


  @override
  void initState() {
    _loadMarkerIcons();
    _checkPermissionAndGetLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned.fill(
          child: currentLatLng == null
              ? const Center(child: CustomLoader())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLatLng!,
              zoom: 14,
            ),
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              if (restaurantIcon != null)
                Marker(
                  markerId: const MarkerId("1"),
                  position: currentLatLng!,
                  icon: restaurantIcon!,
                ),
            },
          ),
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CustomAppBar(
            backgroundColor: Colors.transparent,
            title: 'Map View',
          ),
        ),
        Positioned(
          top: 90.h,
          left: 24.w,
          right: 24.w,
          child:CustomTextField(
              filColor: Colors.white,
              prefixIcon: Icon(Icons.search,color: AppColors.appGreyColor,),
              hintText: 'Search dish name, Cook, cuisines',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppColors.black500TextColor)
              ),
              validator: (_) => null,
              controller: _searchController),

        ),
        Positioned(
          top: 150.h,
          left: 24.w,
          right: 24.w,
          child:SizedBox(
            height: 36.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: HelperData.cuisines.length,
              separatorBuilder: (_, __) => SizedBox(width: 8.w),
              itemBuilder: (context, index) {
                final cuisine = HelperData.cuisines[index];
                final isSelected = cuisine == selectedCuisine;
                return CustomContainer(
                  onTap: () {
                    setState(() => selectedCuisine = cuisine);
                  },                                paddingHorizontal: 14.w, paddingVertical: 6.h,
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.white1TextColor,
                  radiusAll: 20.r,
                  bordersColor: AppColors.colorE7E7E7,
                  child: Center(
                    child: CustomText(text:
                    cuisine,
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

        ),


        Positioned(
          bottom: 90.h,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 210.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: HelperData.restaurants.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = HelperData.restaurants[index];
                return CooksCardWidget( index: index,);
              },),
          ),
        ),
      ],
    );
  }



  Future<void> _loadMarkerIcons() async {
    restaurantIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      Assets.images.mapResturant.path,
    );
    setState(() {}); // refresh to show icon
  }




  Future<void> _checkPermissionAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1️⃣ Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Ask user to enable location services
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enable location services')),
      );
      return;
    }

    // 2️⃣ Check current permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission denied permanently
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permission denied permanently. Please enable from settings.')),
      );
      return;
    }

    // 3️⃣ Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

}
