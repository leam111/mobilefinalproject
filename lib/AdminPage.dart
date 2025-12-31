import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();




  final String apiUrl = 'http://localhost:5000/products';

  Future<void> addProduct() async {
    final int id = int.tryParse(idController.text)??0;
    final String name = nameController.text;
    final String image = imageController.text;
    final String description = descriptionController.text;
    final int price = int.tryParse(pricecontroller.text)??0;

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
       'id': id,
        'name': name,
        'image': image,
        'price':price,
        'description': description
      }),
    );

    if (response.statusCode == 200||response.statusCode==201) {
      idController.clear();
      nameController.clear();
      imageController.clear();
      pricecontroller.clear();
      descriptionController.clear();
      descriptionController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product added successfully')));
          Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add product')));
    }
  }

  Future<void> updateProduct() async {
    final int id = int.tryParse(idController.text) ?? 0;
    final String name = nameController.text;
    final String image = imageController.text;
    final String description = descriptionController.text;
    final int price = int.tryParse(pricecontroller.text)??0;

    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
     'id':id,        
      'name': name,
      'price':price,   
      'description': description,
      'image': image,
      }),
    );

    if (response.statusCode == 200) {
     
     
           idController.clear();
      nameController.clear();
      imageController.clear();
      pricecontroller.clear();
      descriptionController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product updated successfully')));
          Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update product')));
    }
  }

  Future<void> deleteProduct() async {
    final int id = int.tryParse(idController.text) ?? 0;

    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
            idController.clear();
      nameController.clear();
      imageController.clear();
      pricecontroller.clear();      
      descriptionController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product deleted successfully')));
          Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete product')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Admin Editing Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Action Buttons Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Actions',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[700],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: addProduct,
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text("Add"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: updateProduct,
                              icon: const Icon(Icons.edit_outlined),
                              label: const Text("Update"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: deleteProduct,
                              icon: const Icon(Icons.delete_outline),
                              label: const Text("Delete"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Form Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[700],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: idController,
                          decoration: InputDecoration(
                            labelText: "Id",
                            prefixIcon: Icon(Icons.tag, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: Icon(Icons.inventory_2_outlined, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),



                        )
                        ,SizedBox(height: 16,), TextFormField(
                          controller: pricecontroller,
                          decoration: InputDecoration(
                            labelText: "Price",
                            prefixIcon: Icon(Icons.attach_money, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: imageController,
                          decoration: InputDecoration(
                            labelText: "Image URL",
                            prefixIcon: Icon(Icons.image_outlined, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            labelText: "Description",
                            prefixIcon: Icon(Icons.description_outlined, color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
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