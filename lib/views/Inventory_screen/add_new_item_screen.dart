import 'dart:io';
import 'dart:convert';
import 'package:anbar_supliar/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/Inventory_Model/inventory_model_class.dart';

class AddNewItemScreen extends StatefulWidget {
  final InventoryItem? item;

  const AddNewItemScreen({Key? key, this.item}) : super(key: key);

  @override
  _AddNewItemScreenState createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      isEditing = true;
      _nameController.text = widget.item!.title;
      _descriptionController.text = widget.item!.description;
      // Load the image if needed
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> convertImageToBase64(File image) async {
    try {
      List<int> imageBytes = await image.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> saveItem() async {
    try {
      String imageUrl = widget.item?.imageUrl ?? '';
      if (_image != null) {
        String? base64String = await convertImageToBase64(_image!);
        if (base64String != null) {
          imageUrl = base64String;
        }
      }

      InventoryItem newItem = InventoryItem(
        id: widget.item?.id ?? '',
        title: _nameController.text,
        description: _descriptionController.text,
        imageUrl: imageUrl,
      );

      if (isEditing) {
        await FirebaseFirestore.instance
            .collection('inventory')
            .doc(widget.item!.id)
            .update(newItem.toJson());
      } else {
        await FirebaseFirestore.instance
            .collection('inventory')
            .add(newItem.toJson());
      }

      Navigator.pop(context);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save item: ${e.toString()}')),
      );
    }
  }

  bool isBase64(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(isEditing ? editProduct : addNewProduct,
            style: const TextStyle(color: whiteColor)),
      ),
      body: Padding(
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
                    onTap: getImage,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.add, size: 50, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _image != null
                      ? SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : widget.item != null && isBase64(widget.item!.imageUrl)
                          ? SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.memory(
                                  base64Decode(widget.item!.imageUrl),
                                  fit: BoxFit.cover),
                            )
                          : Container(),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 346,
                      height: 323,
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
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 14.0,left: 15.0),
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
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 319,
                            height: 39,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Write  Product Name',
                                  hintStyle : const TextStyle(
                                    fontSize: 11,
                                    fontFamily: semibold,
                                    color: lightHintGreyColor),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: lightBlackColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: primaryColor),),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(top: 14.0,left: 15.0),
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
                          SizedBox(
                            height: 39,
                            width: 319,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: lightBlackColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: primaryColor),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),),),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 36,
                  width: 202,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20, fontFamily: mediam, color: whiteColor),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      await saveItem();
                    },
                    child: Text(isEditing ? 'Save Changes' : 'Submit Item'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
