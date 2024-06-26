import 'package:anbar_supliar/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/inventory_Screen_controller/add_newitem_controller.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';

class AddNewItemScreen extends StatelessWidget {
  final InventoryItem? item;

  const AddNewItemScreen({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddNewItemController controller = Get.put(AddNewItemController());
    controller.initFields(item);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: whiteColor),
        title: Text(controller.isEditing.value ? editProduct : addNewProduct,
            style: const TextStyle(color: whiteColor)),
      ),
      body: Obx(() {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 24, left: 20),
                      child: Text(
                        addProductImage,
                        style: TextStyle(
                            fontSize: 20, fontFamily: semibold, color: primaryColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: controller.getImage,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.add, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(() {
                          if (controller.image.value != null) {
                            return SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(controller.image.value!, fit: BoxFit.cover),
                            );
                          } else if (controller.isEditing.value && item?.imageUrl.isNotEmpty == true) {
                            return SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(item!.imageUrl, fit: BoxFit.cover),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
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
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 14.0, left: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  productName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: semibold,
                                      color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 319,
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextField(
                                  controller: controller.titleController,
                                  decoration: InputDecoration(
                                    hintText: writeProductName,
                                    hintStyle: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: semibold,
                                        color: lightHintGreyColor),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: lightBlackColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.only(top: 14.0, left: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  productPrice,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: semibold,
                                      color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 319,
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: TextField(
                                  controller: controller.priceController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Product Price',
                                    hintStyle: const TextStyle(
                                        fontSize: 11,
                                        fontFamily: semibold,
                                        color: lightHintGreyColor),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: lightBlackColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: primaryColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.only(top: 14.0, left: 15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  productDiscription,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: semibold,
                                      color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                controller: controller.descriptionController,
                                maxLines: null,
                                minLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: lightBlackColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 36,
                        width: 202,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20, fontFamily: mediam,),
                            backgroundColor: primaryColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () async {
                            await controller.saveItem();
                          },
                          child: Obx(() => Text(controller.isEditing.value ? 'Save Changes' : 'Submit Item')),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (controller.isSubmitting.value)
              const Center(
                child: CircularProgressIndicator(color: Colors.black,),
              ),
          ],
        );
      }),
    );
  }
}
