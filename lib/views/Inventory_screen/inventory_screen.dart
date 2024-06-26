import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/inventory_Screen_controller/inventory_controller.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';
import 'add_new_item_screen.dart';
import '../../consts/consts.dart';
import '../../common_widgets/our_button.dart';

class InventoryScreen extends StatelessWidget {
  final InventoryController controller = Get.put(InventoryController());

  InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

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
                controller: searchController,
                onSubmitted: (value) {
                  controller.searchQuery.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search Category',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus(); // Dismiss the keyboard
                        controller.searchQuery.value = searchController.text;
                      },
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
                onPress: () async {
                  final result = await Get.to(() => AddNewItemScreen());
                  if (result != null && result is InventoryItem) {
                    // No need to add item manually here
                    // Firestore snapshot listener will handle the update
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.filteredItems.isEmpty) {
                return const Center(child: Text('No Items Found'));
              }
              return ListView.builder(
                itemCount: controller.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = controller.filteredItems[index];
                  return Dismissible(
                    key: Key(item.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await controller.confirmDeleteItem(item.id);
                    },
                    onDismissed: (direction) {
                      controller.deleteItem(item.id);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: _buildInventoryItem(context, item),
                  );
                },
              );
            }),
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
                  child: item.imageUrl.isNotEmpty
                      ? Image.network(
                    item.imageUrl,
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
                        const SizedBox(height: 5),
                        Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: primaryColor),
                  onPressed: () async {
                    final result = await Get.to(() => AddNewItemScreen(item: item));
                    if (result != null && result is InventoryItem) {
                      // No need to add item manually here
                      // Firestore snapshot listener will handle the update
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
