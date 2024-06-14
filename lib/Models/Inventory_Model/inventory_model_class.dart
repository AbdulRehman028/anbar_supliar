import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  InventoryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
