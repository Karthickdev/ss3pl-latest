class ApiLinks {
  String get mainBase =>
      "http://67.79.237.242/opal/uat/Southshore3PLScanAppApi/users";
  String get fetchBase =>
      "http://67.79.237.242/opal/uat/Southshore3PLScanAppApi/orders/";

  String get base => mainBase;
  String get subbase => fetchBase;
  static const String loginType = "MOB";
  String get login => '$base/VerifyAndGetUserDetails';
  String get getpackSingleorderitemdetails =>
      '$subbase/GetSingleItemPackOrderDetails';
  String get getpackorderitemdetailsmultiitem =>
      '$subbase/GetMultiItemPackOrderDetails';
  String get getpickorderitemdetails => '$subbase/GetPickOrderitemDetails';
  String get updateScanDetails => '$subbase/UpdateScanDetails';
}
