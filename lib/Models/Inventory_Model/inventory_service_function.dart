import 'package:cloud_firestore/cloud_firestore.dart';

import 'inventory_model_class.dart';

Future<List<InventoryItem>> fetchInventoryItems() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('inventory').get();
  return querySnapshot.docs.map((doc) => InventoryItem.fromFirestore(doc)).toList();
}

Future<void> addInventoryItem(InventoryItem item) async {
  await FirebaseFirestore.instance.collection('inventory').add(item.toJson());
}
