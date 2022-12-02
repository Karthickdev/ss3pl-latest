import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_core.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:southshore3pl/providers/getorderitemdetails_provider.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io' as Io;
import 'package:printing/printing.dart';
import 'dart:math' as ma;
import 'package:southshore3pl/router/route_names.dart';

final packappmultiviewprovider =
    ChangeNotifierProvider((ref) => MultiitemViewModel(ref.read));

class MultiitemViewModel extends DefaultChangeNotifier {
  final TextEditingController poController = TextEditingController();
  final TextEditingController upcController = TextEditingController();
  final TextEditingController eventLogController = TextEditingController();
  // FocusNode poFocusNode = new FocusNode();
  bool hidePassword = true;
  late List<TextEditingController> controller;
  List<int> selectedIndex = [];
  bool isavailable = false;
  bool validatemultiitem = false;
  bool validateequal = false;
  int singlepage = 1;
  bool validate302 = false;
  bool validateapi = false;
  bool ifprinting = true;
  String? upcError;
  var file;
  var rng;
  final Reader ref;
  MultiitemViewModel(this.ref);
  bool validateloading = false;
  GetPickOrderitemDetails? getpackdetailsData;
  GetPickOrderitemDetails? get getpackdetailsdata => getpackdetailsData;
  UpdateScanDetails? getupdatescanData;
  UpdateScanDetails? get getupdatescandata => getupdatescanData;
  void clearError() {
    upcError = null;
    notifyListeners();
  }

  void clearDto() {
    getpackdetailsData = null;
    notifyListeners();
  }

  void clearController() {
    poController.text = "";
    upcController.text = "";
    notifyListeners();
  }

  clearUpccontroller({required int index}) {
    controller[index].text = "";
    notifyListeners();
  }

  clearEventLog() {
    eventLogController.text = "";
  }

  bool validate() {
    if (poController.text.isEmpty) {
      upcError = "Please enter upc";
      eventLogController.text =
          "Please enter upc" + '\n' + eventLogController.text;
    }
    return upcError == null;
  }

  void validateAllITEM() {
    if (getpackdetailsData!.orderItemList.any((element) =>
        int.parse(element.quantityorder!) > 1 ||
        int.parse(element.quantityorder!) == 1)) {
    } else {
      validateequal = false;
      notifyListeners();
      validateequal = true;
      notifyListeners();
    }
  }

  void createrandom() {
    rng = ma.Random();
    for (var i = 0; i < 10; i++) {}
  }

  Future submitpackdetails(BuildContext context) async {
    try {
      isavailable = false;
      validate302 = false;
      validateapi = false;
      validateequal = false;
      notifyListeners();
      clearError();
      toggleLoadingOn(true);
      final inputpackdetails = Getpackdetailsinput(
        poBarCode: poController.text,
      );
      getpackdetailsData = await context
          .read(gerorderitemdetailsProvider)
          .getpackDetails(input: inputpackdetails, context: context);
      initialSet();
      if (getpackdetailsData!.orderItemList.length > 1 ||
          getpackdetailsData!.orderItemList.length == 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackBar("PO# has been scanned successfully"));
        eventLogController.text = "PO# has been scanned successfully" +
            '\n' +
            eventLogController.text;
        isavailable = false;
        if (getpackdetailsData!.orderItemList[0].itemScanStatusEnum ==
            "Scanned") {
          isavailable = true;
          for (var i in getpackdetailsData!.orderItemList) {
            i.scannedquantity = i.quantityorder;
            i.quantityorder = "0";
          }
        }
      } else {
        clearController();
        // FocusScope.of(context).requestFocus(poFocusNode);
        ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(getpackdetailsData!.popupMessage.error.toString()));
        eventLogController.text = "${getpackdetailsData!.popupMessage.error}" +
            '\n' +
            eventLogController.text;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }

  void initialSet() {
    controller = List.generate(getpackdetailsData!.orderItemList.length,
        (i) => TextEditingController());
    notifyListeners();
    log(controller.length.toString());
  }

  checkIsValidUpcNumber({required int index, required BuildContext context}) {
    log("UPC NUMBER :::${getpackdetailsData!.orderItemList[index].upc}"
        .toString());
    log("UPC CONTROLER TEXT :::${controller[index].text}".toString());
    if (getpackdetailsData!.orderItemList[index].quantityorder == "0") {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackBar('UPC ALREADY SCANNED'));
      eventLogController.text =
          "UPC ALREADY SCANNED" + '\n' + eventLogController.text;
    } else if (getpackdetailsData!.orderItemList[index].upc ==
            controller[index].text &&
        getpackdetailsData!.orderItemList[index].quantityorder != "0") {
      getpackdetailsData!.orderItemList[index].quantityorder =
          (int.parse(getpackdetailsData!.orderItemList[index].quantityorder!) -
                  1)
              .toString();
      notifyListeners();
      log("QUANTITY ORDER :::${getpackdetailsData!.orderItemList[index].quantityorder}"
          .toString());
      getpackdetailsData!.orderItemList[index].scannedquantity = (int.parse(
                  getpackdetailsData!.orderItemList[index].scannedquantity!) +
              1)
          .toString();
      notifyListeners();
      log("SCANNED ORDER :::${getpackdetailsData!.orderItemList[index].scannedquantity}"
          .toString());
      getpackdetailsData!.orderItemList[index].itemScanStatusEnum =
          40.toString();
      notifyListeners();
      clearUpccontroller(index: index);
      validatemultiitem = true;
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully"));
      eventLogController.text =
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully" +
              '\n' +
              eventLogController.text;
    } else {
      clearUpccontroller(index: index);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          'UPC DOES NOT BELONGS TO THE ITEM # ${getpackdetailsData!.orderItemList[index].itemName}'));
      eventLogController.text =
          "${getpackdetailsData!.orderItemList[index].itemName}" +
              '\n' +
              eventLogController.text;
    }
  }

  Future updateitemfinal(BuildContext context) async {
    try {
      clearError();
      getpackdetailsData!.scanStatusEnum = "40";
      validateloading = true;
      getpackdetailsData!.testvalue = rng.toString();
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData!.popupMessage.information.toString() != "") {
        isavailable = true;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
            getupdatescanData!.popupMessage.information.toString()));
        eventLogController.text =
            getupdatescanData!.popupMessage.information.toString() +
                '\n' +
                eventLogController.text;
      }
      if (getupdatescanData!.popupMessage.information.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("FAIL"));
      }
    } catch (e) {
      log(e.toString());
    } finally {}
  }

  Future updateitem(BuildContext context) async {
    try {
      clearError();
      getpackdetailsData!.scanStatusEnum = "30";
      createrandom();
      toggleLoadingOn(true);
      validateloading = true;
      getpackdetailsData!.testvalue = rng.toString();
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData!.popupMessage.information.toString() != "") {
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
            getupdatescanData!.popupMessage.information.toString()));
        eventLogController.text =
            getupdatescanData!.popupMessage.information.toString() +
                '\n' +
                eventLogController.text;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("FAIL"));
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isavailable = true;
      notifyListeners();
      toggleLoadingOn(false);
    }
  }

  Future skipPrinting(context) async {
    Navigator.pushNamed(context, Routes.trackingnumberscan,
        arguments: getpackdetailsData!);
  }

  Future createPdf(context) async {
    if (getpackdetailsData!.content == null ||
        getpackdetailsData!.content![0].toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("NO PDF FOUND"));
    } else {
      final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
      Uint8List doc = base64.decode(getpackdetailsData!.content![0]);
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              height: 300,
              decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                      fit: pw.BoxFit.cover, image: pw.MemoryImage(doc))),
            );
          }));
      final bool isPrinted = await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
      if (isPrinted) {
        updateitemfinal(
          context,
        );
      }
      clearController();
      clearDto();
      clearError();
      Navigator.pop(context);
      isavailable = false;
      notifyListeners();
      // }
    }
  }
}
