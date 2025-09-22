import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/helpers/menu_show_helper.dart';
import '../../app/helpers/photo_picker_helper.dart';
import '../../app/utils/app_colors.dart';
import '../../custom_assets/assets.gen.dart';
import '../../widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Stack(
              children: [
                CustomImageAvatar(
                  radius: 44.r,
                  image: '',
                ),

                Positioned.fill(
                  child: CustomContainer(
                    onTap: (){
                      PhotoPickerHelper.showPicker(context: context, onImagePicked: (image){});
                    },
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding:  EdgeInsets.all(32.r),
                      child: Assets.icons.cameraAdd.svg(),
                    ),
                  ),
                )

              ],
            ),
            Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomTextField(
                    labelText: 'Full name',
                    controller: _emailController,
                    hintText: "Enter full name",
                  ),
                  CustomTextField(
                    isEmail: true,
                    labelText: 'Email',
                    controller: _nameController,
                    hintText: "Enter Email",
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.phone,
                    labelText: 'Mobile number',
                    controller: _mobileController,
                    hintText: "Enter Mobile number",
                  ),
        
                  SizedBox(height: 60.h,),
                  CustomButton(
                    label: "Save changes",
                    onPressed: _onUpdate,
                  ),
                  SizedBox(
                    height:24.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdate(){
    if(!_globalKey.currentState!.validate()) return;
    // Get.offAllNamed(AppRoutes.resetPasswordSuccess);
  }
}
