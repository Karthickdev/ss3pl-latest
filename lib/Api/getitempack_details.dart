import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/Api/core/api_core.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/models/getpackdetails_input.dart';
import 'package:southshore3pl/models/update_response.dart';
import 'package:southshore3pl/providers/user_provider.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';

mixin getdetails on ApiCore {
  Future<GetPickOrderitemDetails> getpackdetails(
      Getpackdetailsinput input, BuildContext context) async {
    try {
      final uri = Uri.parse(apiLinks.getpackorderitemdetailsmultiitem);
      log("JSON  GET PACK DETAILS :::: ${jsonEncode(input.toJson())}");
      // log('input :: ${input}');
      var response = await apiClient.post(uri,
          headers: deafultHeaders, body: jsonEncode(input));
      log('res:: ${response.body}');
      if (response.statusCode == 401) {
        context.read(userProvider).sessionLogout(context);
      }
      if (response.statusCode == 200) {
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("SOMETHING WENT WRONG"));
      }
      return GetPickOrderitemDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPickOrderitemDetails> getpackdetailsSingle(
      GetpackdetailsinputSingleitem input, BuildContext context) async {
    try {
      final uri = Uri.parse(apiLinks.getpackSingleorderitemdetails);
      log("JSON  GET PACK DETAILS :::: ${jsonEncode(input.toJson())}");
      // log('input :: ${input}');
      var response = await apiClient.post(uri,
          headers: deafultHeaders, body: jsonEncode(input));
      log('res:: ${response.body}');
      if (response.statusCode == 401) {
        context.read(userProvider).sessionLogout(context);
      }
      if (response.statusCode == 200) {
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("SOMETHING WENT WRONG"));
      }
      return GetPickOrderitemDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<GetPickOrderitemDetails> getpickdetails(
      Getpackdetailsinput input, BuildContext context) async {
    try {
      log("JSON  GET PICK DETAILS :::: ${jsonEncode(input.toJson())}");
      final uri = Uri.parse(apiLinks.getpickorderitemdetails);
      var response = await apiClient.post(uri,
          headers: deafultHeaders, body: jsonEncode(input));
      log('res single item:: ${response.body}');
      if (response.statusCode == 401) {
        context.read(userProvider).sessionLogout(context);
      }
      if (response.statusCode == 200) {
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("SOMETHING WENT WRONG"));
      }
      return GetPickOrderitemDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateScanDetails> updatedetails(
      GetPickOrderitemDetails input, BuildContext context) async {
    try {
      final uri = Uri.parse(apiLinks.updateScanDetails);
      log("JSON  UPDATE INPUT:::: ${jsonEncode(input.toJson())}");
      var response = await apiClient.post(uri,
          headers: deafultHeaders, body: jsonEncode(input));
      log('UPDATE RESPONSE:: ${response.body}');
      log('URI:: $uri');
      log('HEADERS:: ${response.headers}');
      if (response.statusCode == 401) {
        context.read(userProvider).sessionLogout(context);
      } else if (response.statusCode != 200 && response.statusCode != 302) {
        ScaffoldMessenger.of(context)
            .showSnackBar(errorSnackBar("SOMETHING WENT WRONG"));
      }
      return UpdateScanDetails.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
