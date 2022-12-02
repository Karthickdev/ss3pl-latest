import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_view_model.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemviewmodel.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/util/sizer.dart';

class Singleitemprinter extends StatefulWidget {
  const Singleitemprinter({Key? key}) : super(key: key);

  @override
  State<Singleitemprinter> createState() => _SingleitemprinterState();
}

class _SingleitemprinterState extends State<Singleitemprinter> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      // final printermmodel = watch(printerViewProvider);
      final singleitemmodel = watch(packappsingleviewprovider);
      final multiitemModel = watch(packappmultiviewprovider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.kColorgrey,
          title: const Text("Printing"),
        ),
        // body :context.read(packappsingleviewprovider).generatePdf(context)
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colors.kColorgrey2,
                  ),
                  child: const Text(
                    'Create & Print PDF',
                  ),
                  onPressed: () {
                    context.read(packappsingleviewprovider).createPdf(
                          context,
                        );
                  }),
              Sizer.vertical20(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colors.kColorgrey2,
                  ),
                  child: const Text(
                    'SKIP',
                  ),
                  onPressed: () {
                    context.read(packappsingleviewprovider).skipPrinting(
                          context,
                        );
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }

  void createPdf() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello eclectify Enthusiast'),
          ); // Center
        },
      ),
    ); // Page
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  void _displayPdf() {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Hello eclectify Enthusiast',
              style: const pw.TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );

    /// open Preview Screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewScreen(doc: doc),
        ));
  }

  /// Convert a Pdf to images, one image per page, get only pages 1 and 2 at 72 dpi
  void convertPdfToImages(pw.Document doc) async {
    await for (var page
        in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage(); // ...or page.toPng()
      print(image);
    }
  }

  /// print an existing Pdf file from a Flutter asset
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load('assets/document.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;
  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: const Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}
