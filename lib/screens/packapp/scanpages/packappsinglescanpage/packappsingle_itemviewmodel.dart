import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_core.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:southshore3pl/providers/getorderitemdetails_provider.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:math' as ma;

final packappsingleviewprovider =
    ChangeNotifierProvider((ref) => SingleitemViewModel(ref.read));

class SingleitemViewModel extends DefaultChangeNotifier {
  final TextEditingController poController = TextEditingController();
  final TextEditingController upcController = TextEditingController();
  final TextEditingController eventLogController = TextEditingController();
  FocusNode poFocusNode = new FocusNode();
  FocusNode upcFocusNode = new FocusNode();
  FocusNode trackingNode = new FocusNode();
  bool bagEnabled = false;
  bool hidePassword = true;
  bool isavailable = false;
  bool validateequal = false;
  int singlepage = 1;
  bool validateapi = false;
  String? trackingerror;
  String? upcError;
  bool disablebagbutton = false;
  var file;
  bool trackingscansuccess = false;
  String? poError;
  bool isJingleBunnies = false;
  var rng;
  int max = 100;
  bool ifprinting = true;
  late List<TextEditingController> controller;
  late List<TextEditingController> trackingcontroller;
  bool validateall = false;
  bool validatemultiitem = false;
  bool validatefalse = false;
  GetPickOrderitemDetails? getpackdetailsData;
  GetPickOrderitemDetails? get getpackdetailsdata => getpackdetailsData;
  UpdateScanDetails? getupdatescanData;
  UpdateScanDetails? get getupdatescandata => getupdatescanData;
  UpdateScanDetails? getupdatescanDatafinal;
  UpdateScanDetails? get getupdatescandatafinal => getupdatescanDatafinal;
  final Reader ref;
  SingleitemViewModel(this.ref);
  bool bagQty = false;

  void clearError() {
    upcError = null;
    poError = null;
    trackingerror = null;
    poFocusNode.unfocus();
    upcFocusNode.unfocus();
    trackingNode.unfocus();
    notifyListeners();
  }

  void clearInputFocus() {
    poFocusNode.unfocus();
    upcFocusNode.unfocus();
    trackingNode.unfocus();
  }

  void clearController() {
    poController.text = "";
    upcController.text = "";

    notifyListeners();
  }

  autofocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void createrandom() {
    rng = ma.Random();
    for (var i = 0; i < 10; i++) {}
  }

  void clearDto() {
    getpackdetailsData = null;
    notifyListeners();
  }

  void upcclearController() {
    upcController.text = "";
    notifyListeners();
  }

  void validateAllITEM() {
    if (getpackdetailsData!.orderItemList.any((element) =>
        int.parse(element.quantityorder!) > 1 ||
        int.parse(element.quantityorder!) == 1)) {
    } else {
      validateequal = true;
      notifyListeners();
    }
  }

  void trackinginitialSet() {
    trackingcontroller = List.generate(getpackdetailsData!.orderItemList.length,
        (i) => TextEditingController());
    notifyListeners();
    print(trackingcontroller);
  }

  clearUpccontroller({required int index}) {
    controller[index].text = "";
    notifyListeners();
  }

  cleartrackingcontroller({required int index}) {
    trackingcontroller[index].text = "";
    notifyListeners();
  }

  clearEventLog() {
    eventLogController.text = "";
  }

  void initialSet() {
    controller = List.generate(getpackdetailsData!.orderItemList.length,
        (i) => TextEditingController());
    notifyListeners();
    print(controller);
  }

  checkIsValidUpcNumber({required int index, required BuildContext context}) {
    if (getpackdetailsData!.orderItemList[index].quantityorder == "0") {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackBar('UPC ALREADY SCANNED'));
      eventLogController.text =
          'UPC ALREADY SCANNED' + '\n' + eventLogController.text;
    } else if (getpackdetailsData!.orderItemList[index].upc ==
            controller[index].text &&
        getpackdetailsData!.orderItemList[index].quantityorder != "0") {
      getpackdetailsData!.orderItemList[index].quantityorder =
          (int.parse(getpackdetailsData!.orderItemList[index].quantityorder!) -
                  1)
              .toString();
      notifyListeners();

      getpackdetailsData!.orderItemList[index].scannedquantity = (int.parse(
                  getpackdetailsData!.orderItemList[index].scannedquantity!) +
              1)
          .toString();
      notifyListeners();

      getpackdetailsData!.orderItemList[index].itemScanStatusEnum =
          40.toString();
      if (getpackdetailsData!.orderItemList[index].quantityorder == "0") {
        validateequal = true;
      }
      notifyListeners();
      clearUpccontroller(index: index);
      upcFocusNode.requestFocus();
      // FocusScope.of(context).requestFocus(upcFocusNode);
      validatemultiitem = true;
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully"));
      eventLogController.text =
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully" +
              '\n' +
              eventLogController.text;
    } else {
      clearUpccontroller(index: index);
      // FocusScope.of(context).requestFocus(upcFocusNode);
      upcFocusNode.requestFocus();
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          'UPC DOES NOT BELONGS TO THE ITEM # ${getpackdetailsData!.orderItemList[index].itemName}'));
      eventLogController.text =
          'UPC DOES NOT BELONGS TO THE ITEM # ${getpackdetailsData!.orderItemList[index].itemName}' +
              '\n' +
              eventLogController.text;
    }
  }

  checkIsValidTrackingNumber(
      {required int index, required BuildContext context}) {
    log("UPC NUMBER :::${getpackdetailsData!.orderItemList[index].upc}"
        .toString());
    // log("QUANTITY ORDER :::${getpackdetailsData!.orderItemList![index].quantityorder!}");
    log("UPC CONTROLER TEXT :::${trackingcontroller[index].text}".toString());
    if (getpackdetailsData!.orderPackageList[index].trackingNumber ==
        trackingcontroller[index].text) {
      getpackdetailsData!.statusEnum = "40";
      notifyListeners();
      getpackdetailsData!.scanStatusEnum = "40";
      notifyListeners();
      getpackdetailsData!.orderPackageList[0].trackingpagescan = "Scanned";
      notifyListeners();
      updateitemfinaltracking(context);
      notifyListeners();
      cleartrackingcontroller(index: index);
      clearDto();
      clearController();
      clearError();
      isavailable = false;
      notifyListeners();
      eventLogController.text = 'Order has been marked as complete on Opal' +
          '\n' +
          eventLogController.text;
      Timer(const Duration(seconds: 5), () {
        log("completed");
        Navigator.pop(context);
        Navigator.pop(context);
      });
      notifyListeners();
    } else {
      cleartrackingcontroller(index: index);
      // FocusScope.of(context).requestFocus(upcFocusNode);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          'TRACKING DOES NOT BELONGS TO THE ITEM # ${getpackdetailsData!.orderItemList[index].itemName}'));
      eventLogController.text =
          'TRACKING DOES NOT BELONGS TO THE ITEM # ${getpackdetailsData!.orderItemList[index].itemName}' +
              '\n' +
              eventLogController.text;
    }
  }

  bool validate() {
    if (poController.text.isEmpty) {
      poError = "Please enter upc";
      eventLogController.text =
          'Please enter upc' + '\n' + eventLogController.text;
    }
    return poError == null;
  }

  void setstatusforbag() {
    getpackdetailsData!.isBagAdded = true.toString();
    disablebagbutton = true;
    isavailable = true;
    notifyListeners();
    isJingleBunnies = false;
    notifyListeners();
  }

  bool validateupc() {
    if (upcController.text.isEmpty) {
      upcError = "Please enter upc";
      eventLogController.text =
          'Please enter upc' + '\n' + eventLogController.text;
    }
    return upcError == null;
  }

  Future submitpackdetailsSingleitem(BuildContext context) async {
    try {
      clearError();
      validateall = false;
      validateequal = false;
      validateapi = false;
      isJingleBunnies = false;
      clearDto();
      notifyListeners();
      toggleLoadingOn(true);
      final inputpackdetails = GetpackdetailsinputSingleitem(
        upcCode: poController.text,
      );
      getpackdetailsData = await context
          .read(gerorderitemdetailsProvider)
          .getpackDetailsSingle(input: inputpackdetails, context: context);
      clearInputFocus();

      if (getpackdetailsData!.orderItemList.length > 1 ||
          getpackdetailsData!.orderItemList.length == 1) {
        if (getpackdetailsData!.orderItemList[0].itemScanStatusEnum ==
            "Scanned") {
          getpackdetailsData!.orderItemList[0].scannedquantity =
              getpackdetailsData!.orderItemList[0].quantityorder;
          getpackdetailsData!.orderItemList[0].quantityorder = "0";
          validateequal = true;
          notifyListeners();
          initialSet();
          disablebagbutton = true;
          isavailable = true;
          clearInputFocus();
          notifyListeners();
          if (getpackdetailsData!.clientName == "Jingle Bunnies") {
            isJingleBunnies = true;
            clearInputFocus();
            notifyListeners();
          } else {
            isJingleBunnies = false;
            disablebagbutton = true;
            notifyListeners();
          }
        } else {
          log(getpackdetailsData!.orderItemList[0].quantityorder.toString());
          for (var item in getpackdetailsData!.orderItemList) {
            if (item.upc == poController.text) {
              getpackdetailsData!.orderItemList[0].quantityorder = (int.parse(
                          getpackdetailsData!.orderItemList[0].quantityorder!) -
                      1)
                  .toString();
              getpackdetailsData!.orderItemList[0].scannedquantity = (int.parse(
                          getpackdetailsData!
                              .orderItemList[0].scannedquantity!) +
                      1)
                  .toString();
              clearInputFocus();
              notifyListeners();
            }
          }
          if (getpackdetailsData!.orderItemList.length == 1 &&
              getpackdetailsData!.orderItemList[0].quantityorder == "0" &&
              getpackdetailsData!.clientName != "Jingle Bunnies") {
            isJingleBunnies = true;
            updateitem(context);
            clearInputFocus();
            notifyListeners();
            disablebagbutton = true;
            notifyListeners();
          }
          if (getpackdetailsData!.orderItemList.length == 1 &&
              getpackdetailsData!.orderItemList[0].quantityorder == "0" &&
              getpackdetailsData!.clientName!.toLowerCase() ==
                  "jingle bunnies") {
            updateitem(context);
            clearInputFocus();
            notifyListeners();
          }
          if (getpackdetailsData!.clientName == "Jingle Bunnies") {
            isJingleBunnies = true;
            clearInputFocus();
            notifyListeners();
          } else {
            disablebagbutton = true;
          }
          clearInputFocus();
          notifyListeners();
          initialSet();
        }

        ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
            "UPC# " + poController.text + "has been scanned successfully"));
        eventLogController.text = "UPC# " +
            poController.text +
            "has been scanned successfully" +
            '\n' +
            eventLogController.text;
      } else {
        clearInputFocus();
        clearController();
        // FocusScope.of(context).requestFocus(poFocusNode);
        ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(getpackdetailsData!.popupMessage.error.toString()));
        eventLogController.text = '${getpackdetailsData!.popupMessage.error}' +
            '\n' +
            eventLogController.text;
      }
    } catch (e) {
      clearInputFocus();
      log(e.toString());
    } finally {
      clearInputFocus();
      toggleLoadingOn(false);
    }
  }

  // Future updateitem(BuildContext context) async {
  //   try {
  //     log("update called");
  //     clearError();
  //     trackinginitialSet;
  //     toggleLoadingOn(true);
  //     notifyListeners();
  //     getpackdetailsData!.statusEnum = 30.toString();
  //     getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
  //     getupdatescanData = await context
  //         .read(gerorderitemdetailsProvider)
  //         .updateDetails(input: getpackdetailsData!, context: context);
  //     log('$getupdatescanData');

  //     if (getpackdetailsData!.orderItemList.isNotEmpty) {
  //       if (getupdatescanData!.orderItemList.length > 0) {
  //         // for (var i = 0; i < getpackdetailsData!.orderItemList.length; i++) {
  //         bagQty = getupdatescanData!.orderItemList
  //             .every((item) => item.itemScanStatusEnum == "Scanned");
  //         log("bag item======>$bagQty");
  //         notifyListeners();
  //         bagEnabled = bagQty ? true : false;
  //         notifyListeners();
  //         log('bagEnabled3==>$bagEnabled');
  //         // }
  //       }
  //     }

  //     if (getupdatescanData!.popupMessage.information.toString() ==
  //         "Order has been marked as complete on OPAL") {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           successSnackBar("Order has been marked as complete on OPAL"));
  //       eventLogController.text = 'Order has been marked as complete on OPAL' +
  //           '\n' +
  //           eventLogController.text;
  //     }
  //     isavailable = true;
  //     if (getupdatescanData == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("FAIL"));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   } finally {
  //     isavailable = true;
  //     notifyListeners();
  //     toggleLoadingOn(false);
  //   }
  // }

  Future updateitem(BuildContext context) async {
    try {
      clearError();
      trackinginitialSet;
      toggleLoadingOn(true);
      notifyListeners();
      getpackdetailsData!.statusEnum = 30.toString();
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData!.popupMessage.information.toString() ==
          "Order has been marked as complete on OPAL") {
        ScaffoldMessenger.of(context).showSnackBar(
            successSnackBar("Order has been marked as complete on OPAL"));
        eventLogController.text = 'Order has been marked as complete on OPAL' +
            '\n' +
            eventLogController.text;
      }
      isavailable = true;
      if (getupdatescanData == null) {
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

  jingglebagEnabled() {
    bagEnabled = bagEnabled ? false : true;
    log('bagEnabled1==>$bagEnabled');

    notifyListeners();
  }

  // Future updateitemfinal(BuildContext context) async {
  //   try {
  //     clearError();
  //     toggleLoadingOn(true);
  //     if (getpackdetailsData!.clientName!.toLowerCase() == "jingle bunnies") {
  //       getpackdetailsData!.isBagAdded = true.toString();
  //       notifyListeners();
  //       isJingleBunnies = true;
  //     } else {
  //       disablebagbutton = true;
  //       notifyListeners();
  //     }
  //     getpackdetailsData!.statusEnum = 30.toString();
  //     getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
  //     if (getpackdetailsData!.orderItemList.isNotEmpty) {
  //       if (getpackdetailsData!.orderItemList.length > 0) {
  //         // for (var i = 0; i < getpackdetailsData!.orderItemList.length; i++) {
  //         bagQty = getpackdetailsData!.orderItemList
  //             .every((item) => item.quantityorder == "0");
  //         log("bag item======>$bagQty");
  //         notifyListeners();
  //         bagEnabled = bagQty ? false : true;
  //         notifyListeners();
  //         // }
  //       }
  //     }
  //     getupdatescanData = await context
  //         .read(gerorderitemdetailsProvider)
  //         .updateDetails(input: getpackdetailsData!, context: context);
  //     if (getupdatescanData!.popupMessage.information.toString() ==
  //         "Bag added successfully.") {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(successSnackBar("Bag added successfully."));
  //       eventLogController.text =
  //           'Bag added successfully.' + '\n' + eventLogController.text;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   } finally {
  //     toggleLoadingOn(false);
  //   }
  // }

  Future updateitemfinal(BuildContext context) async {
    try {
      clearError();
      toggleLoadingOn(true);
      if (getpackdetailsData!.clientName!.toLowerCase() == "jingle bunnies") {
        getpackdetailsData!.isBagAdded = true.toString();
        notifyListeners();
        isJingleBunnies = true;
      } else {
        disablebagbutton = true;
        notifyListeners();
      }
      getpackdetailsData!.statusEnum = 30.toString();
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData!.popupMessage.information.toString() ==
          "Bag added successfully.") {
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackBar("Bag added successfully."));
        eventLogController.text =
            'Bag added successfully.' + '\n' + eventLogController.text;
        if (getpackdetailsData!.clientName!.toLowerCase() == "jingle bunnies") {
          isJingleBunnies = false;
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }

  Future updateitemfinaltracking(BuildContext context) async {
    try {
      clearError();
      toggleLoadingOn(true);
      if (getpackdetailsData!.clientName == "Baywater Design") {
        getpackdetailsData!.isBagAdded = true.toString();
        notifyListeners();
      }
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 40.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData != null &&
          getupdatescanData!.popupMessage != null &&
          getupdatescanData!.popupMessage.information.toString() != "") {
        ScaffoldMessenger.of(context).showSnackBar(
            successSnackBar("Order has been marked as complete on Opal"));
        eventLogController.text = 'Order has been marked as complete on Opal' +
            '\n' +
            eventLogController.text;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }

  Future skipPrinting(context) async {
    Navigator.pushNamed(context, Routes.trackingnumberscan,
        arguments: getpackdetailsData!);
    trackinginitialSet();
  }

  Future createPdf(context) async {
    if (getpackdetailsData!.content == null ||
        getpackdetailsData!.content![0] == "") {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("NO PDF FOUND"));
    } else {
      final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
      log("BASE64 STRING :::::::::${getpackdetailsData!.content}".toString());
      Uint8List doc = base64.decode(getpackdetailsData!.content![0]);
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              height: sizes.height,
              decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(
                      fit: pw.BoxFit.cover, image: pw.MemoryImage(doc))),
            );
          }));
      try {
        final bool isPrinted = await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save());
        if (isPrinted) {
          Navigator.pushNamed(context, Routes.trackingnumberscan,
              arguments: getpackdetailsData!);
        }
        trackinginitialSet();
        log("${getpackdetailsData!.asnSentStatus}");
      } catch (e) {
        log(e.toString());
      } finally {}
    }
  }
}
