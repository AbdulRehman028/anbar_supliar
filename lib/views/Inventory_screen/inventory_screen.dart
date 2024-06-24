// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../../Models/Inventory_Model/inventory_model_class.dart';
// import 'add_new_item_screen.dart';
// import '../../consts/consts.dart';
// import '../../common_widgets/our_button.dart';
// import 'dart:convert';
//
// class InventoryScreen extends StatelessWidget {
//   const InventoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: primaryColor,
//         title: const Text("My Inventory", style: TextStyle(color: Colors.white)),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: SizedBox(
//               width: 342,
//               height: 48,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search Category',
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 31,
//                       width: 31,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.search, color: Colors.white, size: 15),
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 15.0),
//             child: SizedBox(
//               width: 202,
//               height: 35,
//               child: ourButton(
//                 title: 'Add New Item',
//                 color: primaryColor,
//                 textColor: Colors.white,
//                 onPress: () {
//                   Get.to(() => const AddNewItemScreen());
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No Items Found'));
//                 }
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                       InventoryItem item = InventoryItem.fromFirestore(document);
//                       return _buildInventoryItem(context, item);
//                     }).toList(),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInventoryItem(BuildContext context, InventoryItem item) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: item.imageUrl.isNotEmpty && isBase64(item.imageUrl)
//                       ? Image.memory(
//                     base64Decode(item.imageUrl),
//                     width: 105,
//                     height: 116,
//                     fit: BoxFit.cover,
//                   )
//                       : Image.network('https://via.placeholder.com/150', width: 105, height: 116),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.title,
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontFamily: semibold,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           item.description,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontFamily: regular,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.edit_outlined, color: primaryColor),
//                   onPressed: () {
//                     Get.to(() => AddNewItemScreen(item: item));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool isBase64(String str) {
//     try {
//       base64Decode(str);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';
import 'add_new_item_screen.dart';
import '../../consts/consts.dart';
import '../../common_widgets/our_button.dart';
import 'dart:convert'; // Import to decode base64 string

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<List<InventoryItem>> _allItems = ValueNotifier<List<InventoryItem>>([]);
  final ValueNotifier<List<InventoryItem>> _filteredItems = ValueNotifier<List<InventoryItem>>([]);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterItems);
    _searchController.dispose();
    _allItems.dispose();
    _filteredItems.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    _filteredItems.value = _allItems.value.where((item) {
      final title = item.title.toLowerCase();
      final description = item.description.toLowerCase();
      return title.contains(query) || description.contains(query);
    }).toList();
  }

  Future<void> _deleteItem(String itemId) async {
    try {
      await FirebaseFirestore.instance.collection('inventory').doc(itemId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item: ${e.toString()}')),
      );
    }
  }

  void _confirmDeleteItem(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item from inventory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              _deleteItem(itemId);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

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
                controller: _searchController,
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
                  Get.to(() => const AddNewItemScreen());
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Items Found'));
                }

                List<InventoryItem> items = snapshot.data!.docs.map((DocumentSnapshot document) {
                  return InventoryItem.fromFirestore(document);
                }).toList();

                _allItems.value = items;
                _filterItems();

                return ValueListenableBuilder<List<InventoryItem>>(
                  valueListenable: _filteredItems,
                  builder: (context, filteredItems, child) {
                    return ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(filteredItems[index].id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _confirmDeleteItem(context, filteredItems[index].id);
                          },
                          background: Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: AlignmentDirectional.centerEnd,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: _buildInventoryItem(context, filteredItems[index]),
                        );
                      },
                    );
                  },
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