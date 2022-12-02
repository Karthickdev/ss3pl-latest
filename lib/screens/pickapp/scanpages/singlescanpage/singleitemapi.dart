import 'package:http/http.dart' as http;
import 'dart:convert';

class PickappSingleItemScanApiService {
  var baseUrl = "http://67.79.237.242/opal/uat/Southshore3PLScanAppApi/orders/";
  var pickOrderDetails = "GetPickOrderItemDetails";
  var pendingBins = "GetPickScanBatchBinDetails";
  var binItems = "GetPickScanBatchBinItemDetails";
  var serialVerification = "PickScanSerialNumberVerification";

  Future GetPickOrderDetail(url, data) async {
    http.Response response = await http.post(url, body: data);
    return response;
  }

  Future GetPendingBin(url, data) async {
    http.Response response = await http.post(url, body: data);
    return response;
  }

  Future GetBinItems(url, data) async {
    http.Response response = await http.post(url, body: data);
    return response;
  }

  Future verifyserialNumber(url, data) async {
    http.Response response = await http.post(url, body: data);
    return response;
  }
}
