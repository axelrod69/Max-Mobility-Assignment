import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxmobility_assignment/model/customerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customerDataBaseHelper.dart';

class AddCustomerController extends GetxController {
  RxString imageUrl = ''.obs;

  final name = TextEditingController().obs;
  final mobileNumber = TextEditingController().obs;
  final emailId = TextEditingController().obs;
  final latitude = TextEditingController().obs;
  final longitude = TextEditingController().obs;
  final address = TextEditingController().obs;

  final dbHelper = DatabaseHelper();

  void pickImage() async {
    // final picker = ImagePicker();
    final pickedFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      print('Image Path: $image');

      imageUrl.value = image.path.toString();
    } else {}
  }

  void customerValidation() async {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    if (name.value.text.isEmpty) {
      Get.snackbar('Name Needed', 'Please Enter Name',
          snackPosition: SnackPosition.BOTTOM);
    } else if (mobileNumber.value.text.isEmpty) {
      Get.snackbar('Mobile Number Needed', 'Please Enter Mobile Number',
          snackPosition: SnackPosition.BOTTOM);
    } else if (mobileNumber.value.text.length != 10) {
      Get.snackbar('Invalid Mobile Number', 'Please Enter Valid Number',
          snackPosition: SnackPosition.BOTTOM);
    } else if (emailId.value.text.isEmpty) {
      Get.snackbar('Email ID Needed', 'Please Enter Email ID',
          snackPosition: SnackPosition.BOTTOM);
    } else if (!emailRegex.hasMatch(emailId.value.text)) {
      Get.snackbar('Invalid Email', 'Please Enter a Valid Email ID',
          snackPosition: SnackPosition.BOTTOM);
    } else if (latitude.value.text.isEmpty) {
      Get.snackbar('Latitude Needed', 'Please Enter Latitude',
          snackPosition: SnackPosition.BOTTOM);
    } else if (longitude.value.text.isEmpty) {
      Get.snackbar('Longitude Needed', 'Please Enter Longitude',
          snackPosition: SnackPosition.BOTTOM);
    } else if (address.value.text.isEmpty) {
      Get.snackbar('Address Needed', 'Please Enter Address');
    } else if (imageUrl.value.isEmpty) {
      Get.snackbar('Image Needed', 'Please Enter Image',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      saveCustomerData({
        "fullName": name.value.text,
        "mobileNumber": mobileNumber.value.text,
        "emailId": emailId.value.text,
        "latitude": latitude.value.text,
        "longitude": longitude.value.text,
        "address": address.value.text,
        "imageUrl": imageUrl
      }).then((_) => resetData());
    }
  }

  Future<void> saveCustomerData(Map<String, dynamic> customerData) async {
    String fullName = customerData['fullName'] is RxString
        ? (customerData['fullName'] as RxString).value
        : customerData['fullName'] ?? '';

    String mobileNumber = customerData['mobileNumber'] is RxString
        ? (customerData['mobileNumber'] as RxString).value
        : customerData['mobileNumber'] ?? '';

    String emailId = customerData['emailId'] is RxString
        ? (customerData['emailId'] as RxString).value
        : customerData['emailId'] ?? '';

    String latitude = customerData['latitude'] is RxString
        ? (customerData['latitude'] as RxString).value
        : customerData['latitude'] ?? '';

    String longitude = customerData['longitude'] is RxString
        ? (customerData['longitude'] as RxString).value
        : customerData['longitude'] ?? '';

    String address = customerData['address'] is RxString
        ? (customerData['address'] as RxString).value
        : customerData['address'] ?? '';

    String imageUrl = customerData['imageUrl'] is RxString
        ? (customerData['imageUrl'] as RxString).value
        : customerData['imageUrl'] ?? '';

    // Create a new map with extracted values
    Map<String, dynamic> extractedData = {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'emailId': emailId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'imageUrl': imageUrl,
    };

    // Call the insertCustomer method with the extracted data
    await dbHelper.insertCustomer(extractedData);

    Get.snackbar('Success', 'Customer Added',
        snackPosition: SnackPosition.BOTTOM);
  }

  void resetData() {
    name.value.clear();
    mobileNumber.value.clear();
    emailId.value.clear();
    latitude.value.clear();
    longitude.value.clear();
    address.value.clear();
    imageUrl.value = '';
  }
}
