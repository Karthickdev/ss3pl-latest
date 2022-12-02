import 'dart:convert';

GetPickOrderitemDetails getPickOrderitemDetailsFromJson(String str) =>
    GetPickOrderitemDetails.fromJson(json.decode(str));

String getPickOrderitemDetailsToJson(GetPickOrderitemDetails data) =>
    json.encode(data.toJson());

class GetPickOrderitemDetails {
  GetPickOrderitemDetails({
    required this.orderId,
    required this.purchaseOrderNumber,
    required this.shippingMethodEnum,
    required this.testvalue,
    required this.shippingCarrierEnum,
    required this.shippingCarrier,
    required this.shippingMethodString,
    required this.shipToAddress,
    required this.isFromTwoLocations,
    required this.statusEnum,
    required this.numberOfItems,
    required this.orderCreatedDateString,
    required this.orderIdTemp,
    required this.asnSentStatus,
    required this.warehouseId,
    required this.popupMessage,
    required this.content,
    required this.labelAttachmentIds,
    required this.attachmentList,
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
    required this.clientName,
    required this.scanStatusEnum,
    required this.isBagAdded,
  });

  String? orderId;
  String? purchaseOrderNumber;
  String? shippingMethodEnum;
  String? shippingCarrierEnum;
  String? shippingCarrier;
  String? testvalue;
  String? shippingMethodString;
  ShipToAddress shipToAddress;
  String? isFromTwoLocations;
  String? statusEnum;
  String? numberOfItems;
  String? orderCreatedDateString;
  String? orderIdTemp;
  String? asnSentStatus;
  String? warehouseId;
  PopupMessage popupMessage;
  List<String>? content;
  List<int>? labelAttachmentIds;
  String? orderDateString;
  String? orderCreatedDate;
  String? packageId;
  String? itemId;
  String? manageShipmentBoxItems;
  String? shipMethodEnumValue;
  List<OrderItemList> orderItemList;
  List<ItemList> itemList;
  List<OrderPackageList> orderPackageList;
  List<AttachmentList> attachmentList;
  String? isPicked;
  String? isComplete;
  String? clientName;
  String? scanStatusEnum;
  String? isBagAdded;

  factory GetPickOrderitemDetails.fromJson(Map<String, dynamic> json) =>
      GetPickOrderitemDetails(
        orderId: (json["orderId"] ?? "").toString(),
        purchaseOrderNumber: (json["purchaseOrderNumber"] ?? "").toString(),
        shippingMethodEnum: (json["shippingMethodEnum"] ?? "").toString(),
        shippingCarrierEnum: (json["shippingCarrierEnum"] ?? "").toString(),
        shippingCarrier: (json["shippingCarrier"] ?? "").toString(),
        testvalue: (json["testvalue"] ?? "").toString(),
        shippingMethodString: (json["shippingMethodString"] ?? "").toString(),
        shipToAddress: ShipToAddress.fromJson(json["shipToAddress"]),
        isFromTwoLocations: (json["isFromTwoLocations"] ?? "").toString(),
        statusEnum: (json["statusEnum"] ?? "").toString(),
        numberOfItems: (json["numberOfItems"] ?? "").toString(),
        orderCreatedDateString:
            (json["orderCreatedDateString"] ?? "").toString(),
        orderIdTemp: (json["orderIdTemp"] ?? "").toString(),
        asnSentStatus: (json["asnSentStatus"] ?? "").toString(),
        warehouseId: (json["warehouseId"] ?? "").toString(),
        popupMessage: PopupMessage.fromJson(json["popupMessage"] ?? ""),
        content: json["content"] == null
            ? null
            : List<String>.from(json["content"].map((x) => x)),
        labelAttachmentIds: json["labelAttachmentIds"] == null
            ? null
            : List<int>.from(json["labelAttachmentIds"].map((x) => x)),
        attachmentList: List<AttachmentList>.from(
            json["attachmentList"].map((x) => AttachmentList.fromJson(x))),
        orderDateString: (json["orderDateString"] ?? "").toString(),
        orderCreatedDate: (json["orderCreatedDate"] ?? "").toString(),
        packageId: (json["packageId"] ?? "").toString(),
        itemId: (json["itemId"] ?? "").toString(),
        manageShipmentBoxItems:
            (json["manageShipmentBoxItems"] ?? "").toString(),
        shipMethodEnumValue: (json["shipMethodEnumValue"] ?? "").toString(),
        orderItemList: List<OrderItemList>.from(
            json["orderItemList"].map((x) => OrderItemList.fromJson(x))),
        itemList: List<ItemList>.from(
            json["itemList"].map((x) => ItemList.fromJson(x))),
        orderPackageList: List<OrderPackageList>.from(
            json["orderPackageList"].map((x) => OrderPackageList.fromJson(x))),
        isPicked: (json["isPicked"] ?? "").toString(),
        isComplete: (json["isComplete"] ?? "").toString(),
        clientName: (json["clientName"] ?? "").toString(),
        scanStatusEnum: (json["scanStatusEnum"] ?? "").toString(),
        isBagAdded: (json["isBagAdded"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "purchaseOrderNumber": purchaseOrderNumber,
        "shippingMethodEnum": shippingMethodEnum,
        "shippingCarrierEnum": shippingCarrierEnum,
        "shippingCarrier": shippingCarrier,
        "testvalue": testvalue,
        "shippingMethodString": shippingMethodString,
        "shipToAddress": shipToAddress.toJson(),
        "isFromTwoLocations": isFromTwoLocations,
        "statusEnum": statusEnum,
        "numberOfItems": numberOfItems,
        "orderCreatedDateString": orderCreatedDateString,
        "orderIdTemp": orderIdTemp,
        "asnSentStatus": asnSentStatus,
        "warehouseId": warehouseId,
        "popupMessage": popupMessage.toJson(),
        "labelAttachmentIds": labelAttachmentIds,
        "orderDateString": orderDateString,
        "orderCreatedDate": orderCreatedDate,
        "packageId": packageId,
        "itemId": itemId,
        "manageShipmentBoxItems": manageShipmentBoxItems,
        "shipMethodEnumValue": shipMethodEnumValue,
        "orderItemList":
            List<dynamic>.from(orderItemList.map((x) => x.toJson())),
        "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
        "orderPackageList": List<dynamic>.from(orderPackageList.map((x) => x)),
        "isPicked": isPicked,
        "isComplete": isComplete,
        "clientName": clientName,
        "isBagAdded": isBagAdded,
        "ScanStatusEnum": scanStatusEnum
      };
}

class ItemList {
  ItemList({
    required this.itemName,
    required this.upc,
    required this.quantityInStock,
    required this.quantityOnOrder,
  });

  String? itemName;
  String? upc;
  String? quantityInStock;
  String? quantityOnOrder;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemName: (json["itemName"] ?? "").toString(),
        upc: (json["upc"] ?? "").toString(),
        quantityInStock: (json["quantityInStock"] ?? "").toString(),
        quantityOnOrder: (json["quantityOnOrder"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "upc": upc,
        "quantityInStock": quantityInStock,
        "quantityOnOrder": quantityOnOrder,
      };
}

class OrderItemList {
  OrderItemList(
      {required this.orderId,
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
      required this.quantityorder,
      required this.itemScanStatusEnum,
      this.isScanned});

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
  String? shipmentItemAutoId;
  String? quantityorder;
  String? scannedquantity = "0";
  String? itemScanStatusEnum;
  bool? isScanned = false;
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
        shipmentItemAutoId: (json["shipmentItemAutoId"] ?? "").toString(),
        quantityorder: (json["quantity"] ?? "").toString(),
        itemScanStatusEnum: (json["itemScanStatusEnum"] ?? "").toString(),
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
        "ItemScanStatusEnum": itemScanStatusEnum
      };
}

class PopupMessage {
  PopupMessage({required this.error, required this.information});

  String? error;
  String? information;
  factory PopupMessage.fromJson(Map<String, dynamic> json) => PopupMessage(
      error: (json["error"] ?? "").toString(),
      information: (json["information"] ?? "").toString());

  Map<String, dynamic> toJson() => {
        "error": error,
      };
}

class ShipToAddress {
  ShipToAddress({
    required this.addressId,
    required this.shipAdrssTypeString,
    required this.shipAreaSurChrgeString,
    required this.billAdrssTypeString,
    required this.billAreaSurChrgeString,
    required this.name1,
    required this.name2,
    required this.phone,
    required this.email,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.stateText,
    required this.postalCode,
    required this.country,
  });

  String? addressId;
  String? shipAdrssTypeString;
  String? shipAreaSurChrgeString;
  String? billAdrssTypeString;
  String? billAreaSurChrgeString;
  String? name1;
  String? name2;
  String? phone;
  String? email;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? stateText;
  String? postalCode;
  String? country;

  factory ShipToAddress.fromJson(Map<String, dynamic> json) => ShipToAddress(
        addressId: (json["addressId"] ?? "").toString(),
        shipAdrssTypeString: (json["shipAdrssTypeString"] ?? "").toString(),
        shipAreaSurChrgeString:
            (json["shipAreaSurChrgeString"] ?? "").toString(),
        billAdrssTypeString: (json["billAdrssTypeString"] ?? "").toString(),
        billAreaSurChrgeString:
            (json["billAreaSurChrgeString"] ?? "").toString(),
        name1: (json["name1"] ?? "").toString(),
        name2: (json["name2"] ?? "").toString(),
        phone: (json["phone"] ?? "").toString(),
        email: (json["email"] ?? "").toString(),
        address1: (json["address1"] ?? "").toString(),
        address2: (json["address2"] ?? "").toString(),
        city: (json["city"] ?? "").toString(),
        state: (json["state"] ?? "").toString(),
        stateText: (json["stateText"] ?? "").toString(),
        postalCode: (json["postalCode"] ?? "").toString(),
        country: (json["country"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "shipAdrssTypeString": shipAdrssTypeString,
        "shipAreaSurChrgeString": shipAreaSurChrgeString,
        "billAdrssTypeString": billAdrssTypeString,
        "billAreaSurChrgeString": billAreaSurChrgeString,
        "name1": name1,
        "name2": name2,
        "phone": phone,
        "email": email,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "stateText": stateText,
        "postalCode": postalCode,
        "country": country,
      };
}

class OrderPackageList {
  OrderPackageList(
      {required this.packageId,
      required this.orderId,
      required this.length,
      required this.width,
      required this.height,
      required this.weight,
      required this.isScanned,
      required this.createdDate,
      required this.referenceNumber,
      required this.itemQuantity,
      required this.labelPrintStatus,
      required this.asnSentStatus,
      required this.trackingNumber,
      required this.trackingpagescan});
  String? packageId;
  String? orderId;
  String? length;
  String? width;
  String? height;
  String? weight;
  String? isScanned;
  String? trackingpagescan = "UnScanned";
  String? createdDate;
  String? referenceNumber;
  String? itemQuantity;
  String? labelPrintStatus;
  String? asnSentStatus;
  String? trackingNumber;

  factory OrderPackageList.fromJson(Map<String, dynamic> json) =>
      OrderPackageList(
          packageId: (json["packageId"] ?? "").toString(),
          orderId: (json["orderId"] ?? "").toString(),
          length: (json["length"] ?? "").toString(),
          width: (json["width"] ?? "").toString(),
          height: (json["height"] ?? "").toString(),
          weight: (json["weight"] ?? "").toString(),
          isScanned: (json["isScanned"] ?? "").toString(),
          createdDate: (json["createdDate"] ?? "").toString(),
          trackingNumber: (json["trackingNumber"] ?? "").toString(),
          referenceNumber: (json["referenceNumber"] ?? "").toString(),
          itemQuantity: (json["itemQuantity"] ?? "").toString(),
          labelPrintStatus: (json["labelPrintStatus"] ?? "").toString(),
          asnSentStatus: (json["asnSentStatus"] ?? "").toString(),
          trackingpagescan:
              (json["trackingpagescan"] ?? "UnScanned").toString());

  Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "orderId": orderId,
        "length": length,
        "width": width,
        "height": height,
        "weight": weight,
        "isScanned": isScanned,
        "createdDate": createdDate,
        "referenceNumber": referenceNumber,
        "itemQuantity": itemQuantity,
        "labelPrintStatus": labelPrintStatus,
        "asnSentStatus": asnSentStatus,
        "trackingNumber": trackingNumber
      };
}

class AttachmentList {
  AttachmentList({
    this.file,
    this.attachmentId,
    this.name,
    this.mimeType,
    this.extension,
    this.size,
    this.attachmentType,
    this.createdDate,
    this.createdDateString,
    this.enableDelete,
  });

  String? file;
  String? attachmentId;
  String? name;
  String? mimeType;
  String? extension;
  String? size;
  String? attachmentType;
  String? createdDate;
  String? createdDateString;
  String? enableDelete;

  factory AttachmentList.fromJson(Map<String, dynamic> json) => AttachmentList(
      file: (json["file"] ?? "").toString(),
      attachmentId: (json["attachmentId"] ?? "").toString(),
      name: (json["name"] ?? "").toString(),
      mimeType: (json["mimeType"] ?? "").toString(),
      extension: (json["extension"] ?? "").toString(),
      size: (json["size"] ?? "").toString(),
      attachmentType: (json["attachmentType"] ?? "").toString(),
      createdDate: (json["createdDate"] ?? "").toString(),
      createdDateString: (json["createdDateString"] ?? "").toString(),
      enableDelete: (json["enableDelete"] ?? "").toString());

  Map<String, dynamic> toJson() => {
        "file": file,
        "attachmentId": attachmentId,
        "name": name,
        "mimeType": mimeType,
        "extension": extension,
        "size": size,
        "attachmentType": attachmentType,
        "createdDate": createdDate,
        "createdDateString": createdDateString,
        "enableDelete": enableDelete,
      };
}
