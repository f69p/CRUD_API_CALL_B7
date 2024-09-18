import 'dart:convert';

import 'package:crudapplication/screen/update_product.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import 'add_newproduct_screem.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                getProductList();
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text('ProductScreen'),
      ),
      body: _inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return   ListTile(
                      tileColor: Colors.white10,
                      title: Text('Product Name:${productList[index].productName}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product Code: ${productList[index].productCode}'),
                          Text('Product Price: ${productList[index].unitPrice}'),
                          Text('Product Qut:${productList[index].quantity}'),
                          Text('Total Price:${productList[index].TotalPrice}'),
                          Divider(),
                          ButtonBar(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateProductScreen(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                                label: Text('Edit'),
                              ),
                              TextButton.icon(
                                style: ButtonStyle(),
                                onPressed:(){
                                  deleteProduct(productList[index].id);
                                },

                                icon: Icon(Icons.delete,color: Colors.red,),
                                label: Text('Delete',style: TextStyle(color: Colors.red),),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4,
                    );
                  },
                  itemCount: productList.length),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewListScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> getProductList() async {
    _inProgress = true;
    setState(() {});

    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      productList.clear();
      Map<String, dynamic> jsonRespons = jsonDecode(response.body);
      for (var item in jsonRespons['data']) {
        Product product = Product(
          id: item['_id'],
          productName: item['ProductName'] ?? '',
          productCode: item['ProductCode'] ?? '',
          ProductImage: item['Img'] ?? '',
          unitPrice: item['UnitPrice'] ?? '',
          quantity: item['Qty'] ?? '',
          TotalPrice: item['TotalPrice'] ?? '',
          createAt: item['CreatedDate'] ?? '',
        );
        productList.add(product);
      }

      _inProgress = false;
      setState(() {});
    }
  }

  Future<void>deleteProduct(String id)async{
    _inProgress=true;
    Response response=await
    get(Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id'));
    final Map<String,dynamic>decodeRespons=jsonDecode(response.body);
    if(response.statusCode==200 && decodeRespons['status']=='success' ){
      getProductList();
    }else{
      _inProgress=false;
      setState(() {

      });
    }
  }

}
