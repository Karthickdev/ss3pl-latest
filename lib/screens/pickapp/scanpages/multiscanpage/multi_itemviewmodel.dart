import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';
import 'package:southshore3pl/providers/getorderitemdetails_provider.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';

final multiviewprovider =
    ChangeNotifierProvider((ref) => MultiitemViewModel(ref.read));

class MultiitemViewModel extends DefaultChangeNotifier {
  final TextEditingController poController = TextEditingController();
  final TextEditingController upcController = TextEditingController();
  final TextEditingController eventLogController = TextEditingController();
  // FocusNode poFocusNode = new FocusNode();
  //FocusNode upcFocusNode = new FocusNode();
  bool hidePassword = true;
  String? upcError, poError;
  final Reader ref;
  bool validatemultiitem = false;
  bool validateloading = false;
  late List<bool> isBoxSelected;
  List<int> selectedIndex = [];
  int selectedCount = 0;
  bool validateequal = false;
  bool validatefalse = false;
  bool validateotypicked = false;
  int get getCheckboxSelectedCount => selectedCount;
  MultiitemViewModel(this.ref);
  late List<TextEditingController> controller;
  GetPickOrderitemDetails? getpackdetailsData;
  GetPickOrderitemDetails? get getpackdetailsdata => getpackdetailsData;
  UpdateScanDetails? getupdatescanData;
  UpdateScanDetails? get getupdatescandata => getupdatescanData;
  void clearError() {
    upcError = null;
    poError = null;
    notifyListeners();
  }

  void clearDto() {
    getpackdetailsData = null;
    notifyListeners();
  }

  void clearController() {
    poController.text = "";
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
      upcError = "Please enter PO#";
      eventLogController.text =
          "Please enter PO#" + '\n' + eventLogController.text;
    }
    return upcError == null;
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

  void initialSet() {
    controller = List.generate(getpackdetailsData!.orderItemList.length,
        (i) => TextEditingController());
    notifyListeners();
    log(controller.length.toString());
  }

  checkIsValidUpcNumber({required int index, required BuildContext context}) {
    if (getpackdetailsData!.orderItemList[index].quantityorder == "0") {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackBar('UPC ALREADY SCANNED'));
      eventLogController.text =
          "UPC ALREADY SCANNED" + '\n' + eventLogController.text;
    } else if (getpackdetailsData!.orderItemList[index].upc ==
            controller[index].text &&
        getpackdetailsData!.orderItemList[index].quantityorder != "0") {
      // item.quantityorder = (int.parse(item.quantityorder!) - 1).toString();
      getpackdetailsData!.orderItemList[index].quantityorder =
          (int.parse(getpackdetailsData!.orderItemList[index].quantityorder!) -
                  1)
              .toString();
      notifyListeners();

      if (getpackdetailsData!.orderItemList[index].quantityorder == "0") {
        getpackdetailsData!.orderItemList[index].isScanned = true;
      }
      getpackdetailsData!.orderItemList[index].scannedquantity = (int.parse(
                  getpackdetailsData!.orderItemList[index].scannedquantity!) +
              1)
          .toString();
      notifyListeners();

      getpackdetailsData!.orderItemList[index].itemScanStatusEnum =
          30.toString();

      notifyListeners();
      clearUpccontroller(index: index);
      //FocusScope.of(context).requestFocus(upcFocusNode);
      validatemultiitem = true;
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully"));
      eventLogController.text =
          "UPC: ${getpackdetailsData!.orderItemList[index].upc} Scanned successfully" +
              '\n' +
              eventLogController.text;
      var checkAllItems = getpackdetailsData!.orderItemList
          .where((i) => i.isScanned == false)
          .toList();
      if (checkAllItems.isEmpty) {
        //print(checkAllItems);
        updateitem(context);
      }
    } else {
      clearUpccontroller(index: index);
      //FocusScope.of(context).requestFocus(upcFocusNode);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
          'UPC DOES NOT BELONGS TO THE ITEM #${getpackdetailsData!.orderItemList[index].itemName}'));
      eventLogController.text =
          'UPC DOES NOT BELONGS TO THE ITEM #${getpackdetailsData!.orderItemList[index].itemName!}' +
              '\n' +
              eventLogController.text;
    }
    // if (getpackdetailsData!.orderItemList![index].quantityorder! == "0") {
    //   clearUpccontroller(index: index);
    // }
  }

  Future submitpackdetails(BuildContext context) async {
    try {
      clearError();
      validateequal = false;
      toggleLoadingOn(true);
      final inputpackdetails = Getpackdetailsinput(
        poBarCode: poController.text,
      );
      getpackdetailsData = await context
          .read(gerorderitemdetailsProvider)
          .getpickDetails(input: inputpackdetails, context: context);
      if (getpackdetailsData!.orderItemList.length == 1 ||
          getpackdetailsData!.orderItemList.length > 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackBar("PO# has been scanned successfully"));
        eventLogController.text = "PO# has been scanned successfully" +
            '\n' +
            eventLogController.text;
        for (var i in getpackdetailsData!.orderItemList) {
          i.isScanned = false;
        }
        initialSet();
        //FocusScope.of(context).requestFocus(FocusNode());
      } else {
        clearController();
        // FocusScope.of(context).requestFocus(poFocusNode);
        ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar(getpackdetailsData!.popupMessage.error.toString()));
        eventLogController.text =
            getpackdetailsData!.popupMessage.error.toString() +
                '\n' +
                eventLogController.text;
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
      validateloading = true;
      getpackdetailsData!.orderItemList[0].itemScanStatusEnum = 30.toString();
      getupdatescanData = await context
          .read(gerorderitemdetailsProvider)
          .updateDetails(input: getpackdetailsData!, context: context);
      if (getupdatescanData!.popupMessage.information.toString() ==
          "Order has been marked as Picked on OPAL") {
        ScaffoldMessenger.of(context).showSnackBar(successSnackBar(
            getupdatescanData!.popupMessage.information.toString()));
        eventLogController.text =
            "${getupdatescanData!.popupMessage.information}" +
                '\n' +
                eventLogController.text;
        clearController();
        clearDto();
      }
      if (getupdatescanData!.popupMessage.information.toString().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar("FAIL"));
        eventLogController.text =
            "Order update is not successfull" + '\n' + eventLogController.text;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleLoadingOn(false);
    }
  }
}
