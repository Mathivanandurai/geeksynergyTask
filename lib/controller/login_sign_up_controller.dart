import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/utils/validator.dart';

import '../model/sign_up_model.dart';
import '../utils/shared_preference.dart';

class LoginAndSignUpController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String? profession;
  final TextEditingController password = TextEditingController();
  SignUpModel? loggedInUser;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USA", child: Text("Developer")),
      const DropdownMenuItem(value: "Canada", child: Text("User")),
      const DropdownMenuItem(value: "Brazil", child: Text("Admin")),
    ];
    return menuItems;
  }

  callReset() {
    name.clear();
    email.clear();
    phone.clear();
    name.clear();
    profession = null;
    password.clear();
  }

  String? callLogin() {
    try {
      loggedInUser =
          getList().firstWhere((user) => user.name.trim() == name.text.trim());
      if (loggedInUser!.password == password.text.trim()) {
        return null;
      } else {
        return "Incorrect Password";
      }
    } catch (e) {
      return "Please signup to continue";
    }
  }

  Future<String?> callSignUp() async {
    var tempModel = SignUpModel(
        name: name.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        phone: phone.text.trim(),
        profession: profession!.trim());
    var temp = callUserAlreadyExist();
    if (temp == null) {
      await MySharedPref.setUsersList(tempModel);
      return null;
    } else {
      return temp;
    }
  }

  updateProfession(String? newValue) {
    profession = newValue ?? "";
    update();
  }

  String? callUserAlreadyExist() {
    try {
      getList().firstWhere((user) => user.name == name.text);
      return "Name Already Exist,Try with other name";
    } catch (e) {
      return null;
    }
  }

  List<SignUpModel> getList() {
    return List<SignUpModel>.from(MySharedPref.getUsersList()
        .map((e) => SignUpModel.fromJson(json.decode(e))));
  }

  String? nameValidator(String? text) {
    if (text == null) {
      return "Enter your name";
    } else if (text.isEmpty) {
      return "Enter your name";
    }
    return null;
  }

  String? emailValidator(String? text) {
    if (text == null) {
      return "Enter your Email";
    } else if (text.isEmpty) {
      return "Enter your Email";
    } else if (!Validator.emailValidator(text)) {
      return "Enter valid email";
    }
    return null;
  }

  String? phoneValidator(String? text) {
    if (text == null) {
      return "Enter your Phone number";
    } else if (text.isEmpty) {
      return "Enter your Phone number";
    } else if (text.length < 10) {
      return "Enter valid phone number";
    }
    return null;
  }

  String? professionValidator(String? text) {
    if (text == null) {
      return "Select your profession";
    } else if (text.isEmpty) {
      return "Select your profession";
    } else if (text.isEmpty) {
      return "Enter your profession";
    }
    return null;
  }

  String? passwordValidator(String? text) {
    if (text == null) {
      return "Enter password";
    } else if (text.isEmpty) {
      return "Enter password";
    } else if (text.length < 4) {
      return "Password length greater than or equal to 4";
    }
    return null;
  }
}
