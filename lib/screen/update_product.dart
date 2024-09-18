import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
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
final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
bool _inProgres = false;

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text('Update List'),
      ),
      body: _inProgres
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: _buildNewProductForm(),
            ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
      key: _fromkey,
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
            child: ElevatedButton(
              onPressed: _onTapUpdateProduct,
              child: const Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapUpdateProduct() {
    if (_fromkey.currentState!.validate()) {
      UpdateProduct();
    }
  }

  Future<void> UpdateProduct() async {
    _inProgres = true;
    setState(() {});
    Uri uri = Uri.parse(
        'http://164.68.107.70:6060/api/v1/UpdateProduct/6395ce12187245c05d68da82');
    Map<String, dynamic> requestbody = {
      "Img": _textEditingControllerImage.text,
      "ProductCode": _textEditingControllerCode.text,
      "ProductName": _textEditingControllerName.text,
      "Qty": _textEditingControllerQuantity.text,
      "TotalPrice": _textEditingControllerTotalPrice.text,
      "UnitPrice": _textEditingControllerPrice.text
    };
    Response response = await post(uri,
        headers: {"content-Type": "application/json"},
        body: jsonEncode(requestbody));
    if (response.statusCode == 200) {
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update Product Done'),
        ),
      );
    }
    _inProgres = false;
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
