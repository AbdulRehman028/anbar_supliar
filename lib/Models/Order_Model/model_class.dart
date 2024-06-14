import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String id; // Document ID
  final int number;
  final String title;
  final String location;
  final int quantity;
  final String clientName;
  final String contactNumber;
  final String date;
  final int price;
  final String notes;

  Orders(
      {required this.title,
      required this.location,
      required this.quantity,
      required this.number,
      required this.clientName,
      required this.contactNumber,
      required this.date,
      required this.price,
      required this.notes,
      required this.id});

  factory Orders.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Orders(
      id: doc.id,
      number: json['number'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      quantity: json['quantity'] as int,
      clientName: json['clientName'] as String,
      contactNumber: json['contactNumber'] as String,
      date: json['date'] as String,
      price: json['price'] as int,
      notes: json['notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'title': title,
      'location': location,
      'quantity': quantity,
      'clientName': clientName,
      'contactNumber': contactNumber,
      'date': date,
      'price': price,
      'notes': notes,
    };
  }
}
