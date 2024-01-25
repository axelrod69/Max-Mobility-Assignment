import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxmobility_assignment/controller/addCustomerController.dart';
import 'package:maxmobility_assignment/view/homeScreen.dart';

class AddCustomerScreen extends StatelessWidget {
  final AddCustomerController addCustomerController =
      Get.put(AddCustomerController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.to(HomeScreen()),
            // onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 50),
        child: SizedBox(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => addCustomerController.pickImage(),
                    child: Obx(
                      () {
                        final imageUrl = addCustomerController.imageUrl.value;

                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: imageUrl.isEmpty
                              ? Image.asset('assets/defaultPhoto.jpg')
                              : Image.file(File(imageUrl), fit: BoxFit.cover),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.name.value,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your Name',
                  ),
                ),
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.mobileNumber.value,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: 'Enter your Mobile Number',
                  ),
                ),
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.emailId.value,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    hintText: 'Enter your Email',
                  ),
                ),
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.latitude.value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    hintText: 'Enter Latitude',
                  ),
                ),
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.longitude.value,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    hintText: 'Enter Longitude',
                  ),
                ),
              ),
              Obx(
                () => TextField(
                  controller: addCustomerController.address.value,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    hintText: 'Enter Address',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => addCustomerController.customerValidation(
                      // fullNameController.text,
                      // mobileNumberController.text,
                      // emailController.text,
                      // latitudeController.text,
                      // longitudeController.text,
                      // addressController.text
                      ),
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
