import 'package:flutter/material.dart';

import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PdfScreen extends StatelessWidget {
  const PdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Pdf",backgroundColor: Colors.transparent,),
        body: SfPdfViewer.network(
            'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),


    );
  }
}