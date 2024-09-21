import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productapp/widgets/buttonwidget.dart';
 // Import the image picker package
import 'dart:io';

import 'package:productapp/widgets/loginwidget.dart'; // Needed to work with File

 // Import the custom widget

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile; // To store the selected image

  final ImagePicker _picker = ImagePicker();

  // Validators
  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product name';
    }
    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product price';
    } else if (double.tryParse(value) == null) {
      return 'Please enter a valid price';
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }
    return null;
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      // Add product logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomLoginField(
                  controller: _productNameController,
                  labelText: 'Product Name',
                  keyboardType: TextInputType.text,
                  validator: _nameValidator,
                ),
                SizedBox(height: 16),
                CustomLoginField(
                  controller: _productPriceController,
                  labelText: 'Product Price',
                  keyboardType: TextInputType.number,
                  validator: _priceValidator,
                ),
                SizedBox(height: 16),
                CustomLoginField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  keyboardType: TextInputType.text,
                  validator: _descriptionValidator,
                ),
                SizedBox(height: 16),
                // Image picker and display selected image
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        height: 150,
                        width: 150,
                      )
                    : Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                SizedBox(height: 16),
               CustomElevatedButton(label: 'Select Image', onPressed: _pickImage),
                SizedBox(height: 32),
               CustomElevatedButton(label: 'Add Product', onPressed:  _addProduct,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


