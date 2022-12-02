import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:southshore3pl/locator/locator.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

final printerViewProvider =
    ChangeNotifierProvider((ref) => PrinterViewModel(ref.read));

class PrinterViewModel extends DefaultChangeNotifier {
  final pref = locator<Preferences>();
  final Reader ref;
  PrinterViewModel(this.ref);

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

  void displayPdf() {
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
  }

  void generatePdf() async {
    const title = 'eclectify Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(compress: true);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle.defaultStyle()),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  void convertPdfToImages(pw.Document doc) async {
    await for (var page
        in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
      final image = page.toImage(); // ...or page.toPng()
      print(image);
    }
  }
  /// print an existing Pdf file from a Flutter asset
  void printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load('assets/document.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }
}
