class LoginInput {
  final String loginId;
  final String password;

  LoginInput({
   required  this.loginId,
    required this.password,
  });

  Map<String, dynamic> toJson() => {"LoginId": loginId, "Password": password};
}
