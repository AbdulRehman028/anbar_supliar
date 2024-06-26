import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';

class InventoryController extends GetxController {
  var items = <InventoryItem>[].obs;
  var filteredItems = <InventoryItem>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
    searchQuery.listen((query) {
      filterItems();
    });
  }

  void fetchItems() {
    FirebaseFirestore.instance.collection('inventory').snapshots().listen((snapshot) {
      items.value = snapshot.docs.map((doc) {
        try {
          return InventoryItem.fromFirestore(doc);
        } catch (e) {
          print("Error parsing item: $e");
          return null;
        }
      }).where((item) => item != null).cast<InventoryItem>().toList();
      filterItems();
    });
  }

  void filterItems() {
    if (searchQuery.value.isEmpty) {
      filteredItems.value = items;
    } else {
      filteredItems.value = items
          .where((item) =>
      item.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  Future<bool?> confirmDeleteItem(String id) async {
    bool? confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return confirmed;
  }

  void deleteItem(String id) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('inventory').doc(id).get();
      String imageUrl = doc['imageUrl'];
      await FirebaseFirestore.instance.collection('inventory').doc(id).delete();
      if (imageUrl.isNotEmpty) {
        await deleteImageFromStorage(imageUrl);
      }
    } catch (e) {
      print("Error deleting item: $e");
    }
  }

  Future<void> deleteImageFromStorage(String imageUrl) async {
    try {
      Reference storageReference = FirebaseStorage.instance.refFromURL(imageUrl);
      await storageReference.delete();
    } catch (e) {
      print("Error deleting image from storage: $e");
    }
  }
}
