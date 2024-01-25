import 'package:get/get.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/customerModel.dart';
import 'customerDataBaseHelper.dart';

class HomeController extends GetxController {
  RxList<Customer> customersList = <Customer>[].obs;
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxBool isLoading = true.obs;

  Future<void> fetchCustomers() async {
    // isLoading.value = true;
    List<Customer> customers = await databaseHelper.getAllCustomers();

    // Assign the fetched data to the RxList
    customersList.assignAll(customers);

    isLoading.value = false;

    print('Cusomter List: $customersList');

    // Print or use the data as needed
    for (Customer customer in customersList) {
      print('Customer ID: ${customer.id}');
      print('Full Name: ${customer.fullName}');
      // Print other fields as needed
    }
  }
}
