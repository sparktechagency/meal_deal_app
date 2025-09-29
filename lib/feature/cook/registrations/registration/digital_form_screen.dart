import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class DigitalFormScreen extends StatefulWidget {
  const DigitalFormScreen({super.key});

  @override
  State<DigitalFormScreen> createState() => _DigitalFormScreenState();
}

class _DigitalFormScreenState extends State<DigitalFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "The Digital Form  MD(00029)",
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(
                    "https://www.zh.ch/content/dam/zhweb/bilder-dokumente/themen/gesundheit/lebensmittelkontrollen/MD-00029.pdf",
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.registrationSubmittedScreen);
              },
              label: "Sent to KLZH",
            ),
          ],
        ),
      ),
    );
  }
}
