import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl; // This will be a base64 encoded string
  final double price; // Add price field

  InventoryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] != null ? (data['price'] as num).toDouble() : 0.0, // Handle price field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price, // Handle price field
    };
  }
}
