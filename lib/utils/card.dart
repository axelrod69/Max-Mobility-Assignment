import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidget extends StatelessWidget {
  String imageUrl;
  String fullName;
  String mobileNo;
  String emailId;
  String latitude;
  String longitude;
  String address;

  CardWidget(this.imageUrl, this.fullName, this.mobileNo, this.emailId,
      this.latitude, this.longitude, this.address);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.red),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 30,
                //   backgroundColor: Colors.white,
                // ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.file(File(imageUrl), fit: BoxFit.fill),
                ),
                SizedBox(width: 10),
                Text(fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 5),
            Text(mobileNo, style: TextStyle(fontSize: 15)),
            Text(emailId, style: TextStyle(fontSize: 15)),
            Text(address, style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () async {
                      String googleMapsUrl =
                          'https://www.google.com/maps/search/?api=1&query=${double.parse(latitude)},${double.parse(longitude)}';
                      try {
                        await launchUrl(Uri.parse(googleMapsUrl));
                      } catch (e) {
                        print('Error launching Google Maps: $e');
                      }
                      // if (await canLaunch(googleMapsUrl)) {
                      //   await launch(googleMapsUrl);
                      // } else {
                      //   throw 'Could not launch $googleMapsUrl';
                      // }
                    },
                    icon: Icon(Icons.map))
              ],
            )
          ],
        ),
      ),
    );
  }
}
