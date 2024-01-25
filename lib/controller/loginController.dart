import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxmobility_assignment/view/homeScreen.dart';
import 'package:maxmobility_assignment/view/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool checkValidation = false.obs;

  void checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    checkValidation.value = localStorage.getBool('isLoggedIn')!;
  }

  void logOut() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.setBool('isLoggedIn', false);

    Get.to(LoginScreen());
  }

  void loginValidation(String userName, String password) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (userName != 'user@maxmobility.in') {
      Get.snackbar('Invalid Credentials', 'Please Check Your Username',
          snackPosition: SnackPosition.BOTTOM);
    } else if (password != 'Abc@#123') {
      Get.snackbar('Invalid Credentials', 'Please Check Your Password',
          snackPosition: SnackPosition.BOTTOM);
    } else if (userName == '' && password == '') {
      Get.snackbar('Invalid Credentials', 'No Credentials',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      localStorage.setBool('isLoggedIn', true);
      Get.to(HomeScreen());
    }
  }
}
