class Customer {
  int? id; // auto-incremented primary key
  String fullName;
  String mobileNumber;
  String emailId;
  String latitude;
  String longitude;
  String address;
  String imageUrl;

  Customer({
    this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.emailId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.imageUrl,
  });

  // Convert a Customer instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'emailId': emailId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'imageUrl': imageUrl,
    };
  }

  // Create a Customer instance from a Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      fullName: map['fullName'],
      mobileNumber: map['mobileNumber'],
      emailId: map['emailId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      imageUrl: map['imageUrl'],
    );
  }
}
