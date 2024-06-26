import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';

class AddNewItemController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final image = Rxn<File>();
  final picker = ImagePicker();
  final isEditing = false.obs;
  final isSubmitting = false.obs; // Flag to prevent multiple submissions
  String itemId = '';

  void initFields(InventoryItem? item) {
    if (item != null) {
      isEditing.value = true;
      itemId = item.id;
      titleController.text = item.title;
      descriptionController.text = item.description;
      priceController.text = item.price.toString();
      if (item.imageUrl.isNotEmpty) {
        // Preload image from URL if editing
        // Note: Displaying it in the UI should be handled in the view
      }
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadImageToStorage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child("inventory_images/$fileName");
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> saveItem() async {
    if (isSubmitting.value) return; // Prevent multiple submissions

    isSubmitting.value = true;
    try {
      String imageUrl = '';
      if (isEditing.value && itemId.isNotEmpty) {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('inventory').doc(itemId).get();
        imageUrl = doc['imageUrl'] ?? '';
      }
      if (image.value != null) {
        String? uploadedImageUrl = await uploadImageToStorage(image.value!);
        if (uploadedImageUrl != null) {
          imageUrl = uploadedImageUrl;
        }
      }

      InventoryItem newItem = InventoryItem(
        id: isEditing.value ? itemId : '',
        title: titleController.text,
        description: descriptionController.text,
        imageUrl: imageUrl,
        price: double.parse(priceController.text),
      );

      if (isEditing.value) {
        await FirebaseFirestore.instance.collection('inventory').doc(itemId).update(newItem.toJson());
      } else {
        DocumentReference docRef = await FirebaseFirestore.instance.collection('inventory').add(newItem.toJson());
        newItem.id = docRef.id;
      }

      Get.back(result: newItem);
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to save item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
      );
    } finally {
      isSubmitting.value = false; // Reset the flag after submission
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.onClose();
  }
}
