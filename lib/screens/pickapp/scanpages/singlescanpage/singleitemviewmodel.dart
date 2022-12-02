import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:southshore3pl/providers/getorderitemdetails_provider.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';

final singleviewprovider =
    ChangeNotifierProvider((ref) => SingleitemViewModel(ref.read));

class SingleitemViewModel extends DefaultChangeNotifier {
  final TextEditingController poController = TextEditingController();
  final TextEditingController upcController = TextEditingController();
  final TextEditingController eventLogController = TextEditingController();
  // FocusNode poFocusNode = new FocusNode();
  // FocusNode upcFocusNode = new FocusNode();
  bool hidePassword = true;
  bool validateloading = false;
  String? upcError;
  String? poError;
  bool validatemultiitem = false;
  late List<TextEditingController> controller;
  GetPickOrderitemDetails? getpickdetailsData;
  GetPickOrderitemDetails? get getpickdetailsdata => getpickdetailsData;
  UpdateScanDetails? getupdatescanData;
  UpdateScanDetails? get getupdatescandata => getupdatescanData;
  final Reader ref;
  SingleitemViewModel(this.ref);
  bool validateall = false;
  bool validatefalse = false;
  bool validateequal = false;
  void clearError() {
    upcError = null;
    poError = null;
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

  void upcclearController() {
    upcController.text = "";
    notifyListeners();
  }

  void clearDto() {
    getpickdetailsData = null;
    notifyListeners();
  }

  clearEventLog() {
    eventLogController.text = "";
  }

  bool validate() {
    if (poController.text.isEmpty) {
      poError = "Please enter PO#";
      eventLogController.text =
          "Please enter PO#" + '\n' + eventLogController.text;
    }
    return poError == null;
  }

  bool validateupc() {
    if (upcController.text.isEmpty) {
      upcError = "Please enter upc";
      eventLogController.text =
          "Please enter upc" + '\n' + eventLogController.text;
    }
    return upcError == null;
  }

  validateAllITEM() {
    if (getpickdetailsData!.orderItemList.any((element) =>
        int.parse(element.quantityorder!) > 1 ||
        int.parse(element.quantityorder!) == 1)) {
    } else {
      validateequal = true;
      notifyListeners();
    }
  }

  void initialSet() {
    controller = List.generate(getpickdetailsData!.orderItemList.length,
        (i) => TextEditingController());
    notifyListeners();
    log(controller.length.toString());
  }

  checkIsValidUpcNumber({required int index, required BuildContext context}) {
    if (getpickdetailsData!.orderItemList[index].quantityorder! == "0") {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackBar('UPC ALREADY SCANNED'));
      eventLogController.text =
          'UPC already scanned' + '\n' + eventLogController.text;
    } else if (getpickdetailsData!.orderItemList[index].upc ==
            controller[index].text &&
        getpickdetailsData!.orderItemList[index].quantityorder! != "0") {
      // item.quantityorder = (int.parse(item.quantityorder!) - 1).toString();
      getpickdetailsData!.orderItemList[index].quantityorder =
          (int.parse(getpickdetailsData!.orderItemList[index].quantityorder!) -
                  1)
              .toString();
      notifyListeners();

      getpickdetailsData!.orderItemList[index].scannedquantity = (int.parse(
                  getpickdetailsData!.orderItemList[index].scannedquantity!) +
              1)
          .toString();
      notifyListeners();
      if (getpickdetailsData!.orderItemList[index].quantityorder == "0") {
        getpickdetailsData!.orderItemList[index].isScanned = true;
      }
      getpickdetailsData!.orderItemList[index].itemScanStatusEnum =
          30.toString();
      clearUpccontroller(index: index);
      // FocusScope.of(context).requestFocus(upcFocusNode);
      notifyListeners();
      validatemultiitem = true;
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
          "UPC: ${getpickdetailsData!.orderItemList[index].upc} Scanned successfully"));
      eventLogController.text =
          "UPC: ${getpickdetailsData!.orderItemList[index].upc} Scanned successfully" +
              '\n' +
              eventLogController.text;

      // if (getpickdetailsData!.orderItemList[index].quantityorder! == "0") {
      //   updateitem(context);
      // }
      var checkAllItems = getpickdetailsData!.orderItemList
          .where((i) => i.isScanned == false)
          .toList();
      if (checkAllItems.isEmpty) {
        //print(checkAllItems);
        updateitem(context);
      }
    } else {
      clearUpccontroller(index: index);
      // FocusScope.of(context).requestFocus(upcFocusNode);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          'UPC DOES NOT BELONGS TO THE ITEM #${getpickdetailsData!.orderItemList[index].itemName!}'));
      eventLogController.text =
          'UPC DOES NOT BELONGS TO THE ITEM #${getpickdetailsData!.orderItemList[index].itemName!}' +
              '\n' +
              eventLogController.text;
    }
  }

  Future submitpackdetails(BuildContext context) async {
    try {
      clearError();
      validateall = false;
      validateequal = false;
      toggleLoadingOn(true);
      final inputpackdetails = Getpackdetailsinput(
        poBarCode: poController.text,
      );
      getpickdetailsData = await context
          .read(gerorderitemdetailsProvider)
          .getpickDetails(input: inputpackdetails, context: context);
      if (getpickdetailsData!.itemList.length == 1 ||
          getpickdetailsData!.itemList.length > 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackBar("PO# has been scanned successfully"));
        eventLogController.text = "PO# has been scanned successfully" +
            '\n' +
            eventLogController.text;
        for (var i in getpickdetailsData!.orderItemList) {
          i.isScanned = false;
        }
        upcclearController();
        initialSet();
        //FocusScope.of(context).requestFocus(FocusNode());
        //FocusScope.of(context).requestFocus(upcFocusNode);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(getpickdetailsData!.popupMessage.error.toString()));
        eventLogController.text =
            getpickdetailsData!.popupMessage.error.toString() +
                '\n' +
                eventLogController.text;
        clearController();
        // FocusScope.of(context).requestFocus(poFocusNode);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }

  Future updateitem(BuildContext context) async {
    try {
      clearError();
      toggleLoadingOn(true);
      getpickdetailsData!.orderItemList[0].itemScanStatusEnum = 30.toString();
      getpickdetailsData!.scanStatusEnum = 30.toString();
      validateloading = true;
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpickdetailsData!, context: context);
      if (getupdatescanData!.scanStatusEnum == "Picked") {
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
            getupdatescanData!.popupMessage.information.toString()));
        eventLogController.text =
            "${getupdatescanData!.popupMessage.information}" +
                '\n' +
                eventLogController.text;
        clearController();
        clearDto();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("Order update is not successfull"));
        eventLogController.text =
            "Order update is not successfull" + '\n' + eventLogController.text;
      }
      if (getupdatescanData!.popupMessage.information.toString().isEmpty) {}
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }
}
