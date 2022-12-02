// To parse this JSON data, do
//
//     final getpackdetailsinput = getpackdetailsinputFromJson(jsonString);

import 'dart:convert';

Getpackdetailsinput getpackdetailsinputFromJson(String str) =>
    Getpackdetailsinput.fromJson(json.decode(str));

String getpackdetailsinputToJson(Getpackdetailsinput data) =>
    json.encode(data.toJson());

class Getpackdetailsinput {
  Getpackdetailsinput({
   required this.poBarCode,
  });

  String? poBarCode;

  factory Getpackdetailsinput.fromJson(Map<String, dynamic> json) =>
      Getpackdetailsinput(
        poBarCode: (json["poBarCode"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "poBarCode": poBarCode,
      };
}
class GetpackdetailsinputSingleitem {
  GetpackdetailsinputSingleitem({
   required this.upcCode,
  });

  String? upcCode;

  factory GetpackdetailsinputSingleitem.fromJson(Map<String, dynamic> json) =>
      GetpackdetailsinputSingleitem(
        upcCode: (json["upcCode"] ?? "").toString(),
      );

  Map<String, dynamic> toJson() => {
        "upcCode": upcCode,
      };
}

