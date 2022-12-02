import 'package:http/http.dart' show Client;
import 'package:southshore3pl/Api/core/api_links.dart';
import 'package:southshore3pl/global/preferences.dart';
import 'package:southshore3pl/locator/locator.dart';
export 'dart:convert';

class ApiCore {
  final apiClient = Client();
  final prefs = locator<Preferences>();
  final apiLinks = locator<ApiLinks>();

  void dispose() {
    apiClient.close();
  }
}

Map<String, String> get deafultHeaders {
  return {
   'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': 'application/json',
  };
}
