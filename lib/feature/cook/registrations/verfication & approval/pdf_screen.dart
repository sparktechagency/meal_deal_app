import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  final String pdfUrl = Get.arguments ?? '';
  final PdfViewerController _pdfViewerController = PdfViewerController();

  bool hasScrolledToEnd = false;
  int currentPage = 0;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController.addListener(_onPdfPageChanged);
  }

  @override
  void dispose() {
    _pdfViewerController.removeListener(_onPdfPageChanged);
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _onPdfPageChanged() {
    final pageNumber = _pdfViewerController.pageNumber;
    final pageCount = _pdfViewerController.pageCount;

    setState(() {
      currentPage = pageNumber;
      totalPages = pageCount;

      // Check if user has reached the last page
      if (pageNumber == pageCount && pageCount > 0) {
        hasScrolledToEnd = true;
      }
    });
  }

  Future<void> _handleNextButton() async {
    if (!hasScrolledToEnd) {
      return;
    }
    final bool success = await Get.find<AuthController>().trackMe(type:'course-pdf',user: true);
    if(success){

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(title: "PDF Document"),
      body: Column(
        children: [
          // Progress indicator
          if (totalPages > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              color: Colors.orange.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page $currentPage of $totalPages',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  if (hasScrolledToEnd)
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green,
                            size: 18.sp
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

          // PDF Viewer
          Expanded(
            child: pdfUrl.isEmpty
                ? Center(
              child: Text(
                'No PDF URL provided',
                style: TextStyle(fontSize: 16.sp),
              ),
            )
                : SfPdfViewer.network(
              pdfUrl,
              controller: _pdfViewerController,
              onDocumentLoadFailed: (details) {
                showToast(
                  'Failed to load PDF: ${details.error}',
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: SafeArea(
          child: GetBuilder<AuthController>(
            builder: (controller) {
              return CustomButton(
                onPressed: _handleNextButton,
                label:controller.isLoadingTrack ? 'Loading...' : 'Complete & Continue',
                backgroundColor: hasScrolledToEnd
                    ? Color(0xFFE67E22)
                    : Colors.grey.shade400,
              );
            }
          ),
        ),
      ),
    );
  }
}