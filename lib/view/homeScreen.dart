import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxmobility_assignment/controller/homeController.dart';
import 'package:maxmobility_assignment/view/addCustomerScreen.dart';
import '../controller/loginController.dart';
import '../utils/card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState

    homeController.fetchCustomers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () => loginController.logOut(),
                  icon: const Icon(Icons.logout))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => Get.to(AddCustomerScreen()),
            child: const Text('+',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          body: homeController.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : homeController.customersList.isEmpty
                  ? const Center(
                      child: Text('No Customer Added Yet'),
                    )
                  :
                  // homeController.mapData.isEmpty ? const Center(child: Text('No Customer Added')) :
                  Obx(
                      () => ListView.builder(
                        itemBuilder: (context, index) => CardWidget(
                            homeController.customersList[index].imageUrl,
                            homeController.customersList[index].fullName,
                            homeController.customersList[index].mobileNumber,
                            homeController.customersList[index].emailId,
                            homeController.customersList[index].latitude,
                            homeController.customersList[index].longitude,
                            homeController.customersList[index].address),
                        itemCount: homeController.customersList.length,
                      ),
                    )),
    );
  }
}
