import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_exporter.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:southshore3pl/locator/locator.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/core/default_change_notifier.dart';

final gerorderitemdetailsProvider =
    ChangeNotifierProvider((ref) => GetorderdetailsProvider());

class GetorderdetailsProvider extends DefaultChangeNotifier {
  final pref = locator<Preferences>();
  final api = locator<ApiExporter>();
  GetPickOrderitemDetails? getPickOrderitemDetailsData;
  GetPickOrderitemDetails? get getPickOrderitemDetailsdata =>
      getPickOrderitemDetailsData;
  GetPickOrderitemDetails? getPackOrderitemDetailsData;
  GetPickOrderitemDetails? get getPackOrderitemDetailsdata =>
      getPackOrderitemDetailsData;
  UpdateScanDetails? updatedetailsData;
  UpdateScanDetails? get updatedetailsdata => updatedetailsData;
  int updating = 0;

  Future<GetPickOrderitemDetails?> getpickDetails(
      {required Getpackdetailsinput input,
      required BuildContext context}) async {
    try {
      toggleLoadingOn(true);
      getPickOrderitemDetailsData = await api.getpickdetails(input, context);
      notifyListeners();
      return getPickOrderitemDetailsData;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPickOrderitemDetails?> getpackDetails(
      {required Getpackdetailsinput input,
      required BuildContext context}) async {
    try {
      toggleLoadingOn(true);
      getPackOrderitemDetailsData = await api.getpackdetails(input, context);
      notifyListeners();
      return getPackOrderitemDetailsData;
    } catch (e) {
      rethrow;
    }
  }
  Future<GetPickOrderitemDetails?> getpackDetailsSingle(
      {required GetpackdetailsinputSingleitem input,
      required BuildContext context}) async {
    try {
      toggleLoadingOn(true);
      getPackOrderitemDetailsData = await api.getpackdetailsSingle(input, context);
      notifyListeners();
      return getPackOrderitemDetailsData;
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateScanDetails?> updateDetails(
      {required GetPickOrderitemDetails input,
      required BuildContext context}) async {
    try {
      toggleLoadingOn(true);
      updating + 1;
      updatedetailsData = await api.updatedetails(input, context);
      notifyListeners();
      return updatedetailsData;
    } catch (e) {
      rethrow;
    }
  }

  Future sessionLogout(BuildContext context) async {
    try {
      log("Logout Device");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        pref.clearLocalPref();
        Phoenix.rebirth(context);
      });
    } catch (e) {
      rethrow;
    }
  }
}
