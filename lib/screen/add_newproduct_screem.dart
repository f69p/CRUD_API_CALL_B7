import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewListScreen extends StatefulWidget {
  const AddNewListScreen({super.key});

  @override
  State<AddNewListScreen> createState() => _AddNewListScreenState();
}

final TextEditingController _textEditingControllerName =
    TextEditingController();
final TextEditingController _textEditingControllerCode =
    TextEditingController();
final TextEditingController _textEditingControllerPrice =
    TextEditingController();
final TextEditingController _textEditingControllerQuantity =
    TextEditingController();
final TextEditingController _textEditingControllerTotalPrice =
    TextEditingController();
final TextEditingController _textEditingControllerImage =
    TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool _inProgress = false;

class _AddNewListScreenState extends State<AddNewListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('AddNewList'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildNewProductForm(),
        ),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _textEditingControllerName,
            decoration: const InputDecoration(
                hintText: 'Product Name',
                label: Text('Enter Product Name'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textEditingControllerCode,
            decoration: const InputDecoration(
                hintText: 'Product Code',
                label: Text('Enter Product Code'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textEditingControllerPrice,
            decoration: const InputDecoration(
                hintText: 'Product Price',
                label: Text('Enter Product Price'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textEditingControllerQuantity,
            decoration: const InputDecoration(
                hintText: 'Product Quantity',
                label: Text('Enter Product Quantity'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textEditingControllerTotalPrice,
            decoration: const InputDecoration(
                hintText: 'Product Total Price',
                label: Text('Enter Product Total Price'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _textEditingControllerImage,
            decoration: const InputDecoration(
                hintText: 'Product Image',
                label: Text('Enter Product Image'),
                border: OutlineInputBorder()),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: _inProgress
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: _onTapAddProduct,
                    child: const Text('Add Product'),
                  ),
          ),
        ],
      ),
    );
  }

  void _onTapAddProduct() {
    if (_formkey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
      "Img": _textEditingControllerImage.text,
      "ProductCode": _textEditingControllerCode.text,
      "ProductName": _textEditingControllerName.text,
      "Qty": _textEditingControllerQuantity.text,
      "TotalPrice": _textEditingControllerTotalPrice.text,
      "UnitPrice": _textEditingControllerPrice.text,
    };

    Response response = await post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _clearTextFields();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('New Product Added')));
    }

    _inProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _textEditingControllerPrice.clear();
    _textEditingControllerTotalPrice.clear();
    _textEditingControllerQuantity.clear();
    _textEditingControllerName.clear();
    _textEditingControllerCode.clear();
    _textEditingControllerImage.clear();
  }
}
