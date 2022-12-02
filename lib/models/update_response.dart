// To parserequired this JSON data, do
//
//     final updateScanDetails = updateScanDetailsFromJson(jsonString);

import 'dart:convert';

UpdateScanDetails updateScanDetailsFromJson(String str) =>
    UpdateScanDetails.fromJson(json.decode(str));

String updateScanDetailsToJson(UpdateScanDetails data) =>
    json.encode(data.toJson());

class UpdateScanDetails {
  UpdateScanDetails({
    required this.orderId,
    required this.purchaseOrderNumber,
    required this.shippingMethodEnum,
    required this.shippingCarrierEnum,
    required this.shipToAddress,
    required this.isFromTwoLocations,
    required this.statusEnum,
    required this.numberOfItems,
    required this.orderCreatedDateString,
    required this.orderIdTemp,
    required this.asnSentStatus,
    required this.warehouseId,
    required this.popupMessage,
    required this.scanStatusEnum,
    required this.orderDateString,
    required this.orderCreatedDate,
    required this.packageId,
    required this.itemId,
    required this.manageShipmentBoxItems,
    required this.shipMethodEnumValue,
    required this.orderItemList,
    required this.itemList,
    required this.orderPackageList,
    required this.isPicked,
    required this.isComplete,
  });

  String? orderId;
  String? purchaseOrderNumber;
  String? shippingMethodEnum;
  String? shippingCarrierEnum;
  ShipToAddress shipToAddress;
  String? isFromTwoLocations;
  String? statusEnum;
  String? numberOfItems;
  String? orderCreatedDateString;
  String? orderIdTemp;
  String? asnSentStatus;
  String? warehouseId;
  PopupMessage popupMessage;
  String? scanStatusEnum;
  String? orderDateString;
  String? orderCreatedDate;
  String? packageId;
  String? itemId;
  String? manageShipmentBoxItems;
  String? shipMethodEnumValue;
  List<OrderItemList> orderItemList;
  List<dynamic> itemList;
  List<dynamic> orderPackageList;
  String? isPicked;
  String? isComplete;

  factory UpdateScanDetails.fromJson(Map<String, dynamic> json) =>
      UpdateScanDetails(
        orderId: (json["orderId"] ?? "").toString(),
        purchaseOrderNumber: (json["purchaseOrderNumber"] ?? "").toString(),
        shippingMethodEnum: (json["shippingMethodEnum"] ?? "").toString(),
        shippingCarrierEnum: (json["shippingCarrierEnum"] ?? "'").toString(),
        shipToAddress: ShipToAddress.fromJson(json["shipToAddress"]),
        isFromTwoLocations: (json["isFromTwoLocations"] ?? "").toString(),
        statusEnum: (json["statusEnum"] ?? "").toString(),
        numberOfItems: (json["numberOfItems"] ?? "").toString(),
        orderCreatedDateString:
            (json["orderCreatedDateString"] ?? "").toString(),
        orderIdTemp: (json["orderIdTemp"] ?? "").toString(),
        asnSentStatus: (json["asnSentStatus"] ?? "").toString(),
        warehouseId: (json["warehouseId"] ?? "").toString(),
        popupMessage: PopupMessage.fromJson(json["popupMessage"]),
        scanStatusEnum: (json["scanStatusEnum"] ?? "").toString(),
        orderDateString: (json["orderDateString"] ?? "").toString(),
        orderCreatedDate: (json["orderCreatedDate"] ?? "").toString(),
        packageId: (json["packageId"] ?? "").toString(),
        itemId: (json["itemId"] ?? "").toString(),
        manageShipmentBoxItems:
            (json["manageShipmentBoxItems"] ?? "").toString(),
        shipMethodEnumValue: (json["shipMethodEnumValue"] ?? "").toString(),
        orderItemList: List<OrderItemList>.from(
            json["orderItemList"].map((x) => OrderItemList.fromJson(x))),
        itemList: List<dynamic>.from(json["itemList"].map((x) => x)),
        orderPackageList:
            List<dynamic>.from(json["orderPackageList"].map((x) => x)),
        isPicked: (json["isPicked"] ?? "").toString(),
        isComplete: (json["isComplete"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "purchaseOrderNumber": purchaseOrderNumber,
        "shippingMethodEnum": shippingMethodEnum,
        "shippingCarrierEnum": shippingCarrierEnum,
        "shipToAddress": shipToAddress.toJson(),
        "isFromTwoLocations": isFromTwoLocations,
        "statusEnum": statusEnum,
        "numberOfItems": numberOfItems,
        "orderCreatedDateString": orderCreatedDateString,
        "orderIdTemp": orderIdTemp,
        "asnSentStatus": asnSentStatus,
        "warehouseId": warehouseId,
        "popupMessage": popupMessage.toJson(),
        "scanStatusEnum": scanStatusEnum,
        "orderDateString": orderDateString,
        "orderCreatedDate": orderCreatedDate,
        "packageId": packageId,
        "itemId": itemId,
        "manageShipmentBoxItems": manageShipmentBoxItems,
        "shipMethodEnumValue": shipMethodEnumValue,
        "orderItemList":
            List<dynamic>.from(orderItemList.map((x) => x.toJson())),
        "itemList": List<dynamic>.from(itemList.map((x) => x)),
        "orderPackageList": List<dynamic>.from(orderPackageList.map((x) => x)),
        "isPicked": isPicked,
        "isComplete": isComplete,
      };
}

class OrderItemList {
  OrderItemList({
    required this.orderId,
    required this.itemId,
    required this.subItemId,
    required this.itemName,
    required this.itemTypeEnum,
    required this.quantity,
    required this.upc,
    required this.fillPercent,
    required this.parentSku,
    required this.skipScan,
    required this.shipmentItemAutoId,
    required this.itemScanStatusEnum,
  });

  String? orderId;
  String? itemId;
  String? subItemId;
  String? itemName;
  String? itemTypeEnum;
  String? quantity;
  String? upc;
  String? fillPercent;
  String? parentSku;
  String? skipScan;
  String? itemScanStatusEnum;
  String? shipmentItemAutoId;

  factory OrderItemList.fromJson(Map<String, dynamic> json) => OrderItemList(
        orderId: (json["orderId"] ?? "").toString(),
        itemId: (json["itemId"] ?? "").toString(),
        subItemId: (json["subItemId"] ?? "").toString(),
        itemName: (json["itemName"] ?? "").toString(),
        itemTypeEnum: (json["itemTypeEnum"] ?? "").toString(),
        quantity: (json["quantity"] ?? "").toString(),
        upc: (json["upc"] ?? "").toString(),
        fillPercent: (json["fillPercent"] ?? "").toString(),
        parentSku: (json["parentSku"] ?? "").toString(),
        skipScan: (json["skipScan"] ?? "").toString(),
        itemScanStatusEnum: (json["itemScanStatusEnum"] ?? "").toString(),
        shipmentItemAutoId: (json["shipmentItemAutoId"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "itemId": itemId,
        "subItemId": subItemId,
        "itemName": itemName,
        "itemTypeEnum": itemTypeEnum,
        "quantity": quantity,
        "upc": upc,
        "fillPercent": fillPercent,
        "parentSku": parentSku,
        "skipScan": skipScan,
        "shipmentItemAutoId": shipmentItemAutoId,
      };
}

class PopupMessage {
  PopupMessage({
    required this.information,
  });

  String? information;

  factory PopupMessage.fromJson(Map<String, dynamic> json) => PopupMessage(
        information: (json["information"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "information": information,
      };
}

class ShipToAddress {
  ShipToAddress();

  factory ShipToAddress.fromJson(Map<String, dynamic> json) => ShipToAddress();

  Map<String, dynamic> toJson() => {};
}
