// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
    UserLogin({
       required this.userId,
       required this.firstName,
       required this.lastName,
       required this.email,
       required this.loginId,
       required this.mustChangePassword,
       required this.failedPasswordAttemptCount,
       required this.isLockedOut,
       required this.lastLockedOutDate,
       required this.isPasswordExpired,
       required this.status
    });

    String? userId;
    String? firstName;
    String? lastName;
    String? email;
    String? loginId;
    String? mustChangePassword;
    String? failedPasswordAttemptCount;
    String? isLockedOut;
    String? lastLockedOutDate;
    String? isPasswordExpired;
    String? status;

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        userId: (json["userId"]?? "").toString(),
        firstName: (json["firstName"]?? "").toString(),
        lastName: (json["lastName"]?? "").toString(),
        email: (json["email"]?? "").toString(),
        loginId: (json["loginId"]?? "").toString(),
        mustChangePassword: (json["mustChangePassword"]?? "").toString(),
        failedPasswordAttemptCount: (json["failedPasswordAttemptCount"]?? "").toString(),
        isLockedOut: (json["isLockedOut"]?? "").toString(),
        lastLockedOutDate: (json["lastLockedOutDate"]?? "").toString(),
        isPasswordExpired:( json["isPasswordExpired"]?? "").toString(),
        status:( json["status"]?? "").toString(),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "loginId": loginId,
        "mustChangePassword": mustChangePassword,
        "failedPasswordAttemptCount": failedPasswordAttemptCount,
        "isLockedOut": isLockedOut,
        "lastLockedOutDate": lastLockedOutDate,
        "isPasswordExpired": isPasswordExpired,
        "status":status
    };
}
