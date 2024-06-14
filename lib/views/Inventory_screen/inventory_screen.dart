import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';
import 'add_new_item_screen.dart';
import '../../consts/consts.dart';
import '../../common_widgets/our_button.dart';
import 'dart:convert'; // Import to decode base64 string

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: const Text("My Inventory", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 342,
              height: 48,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Category',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.search, color: Colors.white, size: 15),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: SizedBox(
              width: 202,
              height: 35,
              child: ourButton(
                title: 'Add New Item',
                color: primaryColor,
                textColor: Colors.white,
                onPress: () {
                  Get.to(() => AddNewItemScreen());
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No Items Found'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      InventoryItem item = InventoryItem.fromFirestore(document);
                      return _buildInventoryItem(context, item);
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(BuildContext context, InventoryItem item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: item.imageUrl.isNotEmpty && isBase64(item.imageUrl)
                      ? Image.memory(
                    base64Decode(item.imageUrl),
                    width: 105,
                    height: 116,
                    fit: BoxFit.cover,
                  )
                      : Image.network('https://via.placeholder.com/150', width: 105, height: 116),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: semibold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: regular,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: primaryColor),
                  onPressed: () {
                    Get.to(() => AddNewItemScreen(item: item));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isBase64(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}

