class LoginModel {
  String id;
  String userName;
  String? headFamilyId;
  String? password;
  LoginModel({
    required this.id,
    required this.userName,
    this.headFamilyId,
    this.password,
  });
}

class ChangePassword {
  String id;
  String oldPassword;
  String newPassword;
  ChangePassword({
    required this.id,
    required this.oldPassword,
    required this.newPassword,
  });
}

class Failure {
  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success

  Failure({required this.code, required this.message});
}

class Passwords {
  String old;
  String newPass;
  String id;
  Passwords({
    required this.old,
    required this.newPass,
    required this.id,
  });
}
