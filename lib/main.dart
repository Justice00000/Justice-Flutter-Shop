// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this to use GetMaterialApp
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  List<Product> products = [
    Product(name: 'Chuchu Pads', imageUrl: 'assets/images/Img1.jpg', price: 29.99),
    Product(name: 'Baby Boy', imageUrl: 'assets/images/Img2.jpg', price: 49.99),
    Product(name: 'Ladies', imageUrl: 'assets/images/Img3.jpg', price: 19.99),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Store',
      theme: isDarkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: CatalogPage(toggleTheme: toggleTheme, products: products),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final List<Product> products;

  const CatalogPage({super.key, required this.toggleTheme, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products.length,
        shrinkWrap: true, // Allows the GridView to take only the needed space
        physics: const NeverScrollableScrollPhysics(), // Prevents scrolling in the GridView
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Get.snackbar('Product Selected', product.name);
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Set to minimum to avoid overflow
                children: [
                  Expanded( // Wrap Image and Text in Expanded to prevent overflow
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover, // Ensure the image fits properly
                      width: double.infinity, // Make sure the image takes full width
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0), // Add some padding around text
                    child: Column(
                      children: [
                        Text(product.name, textAlign: TextAlign.center),
                        Text('\$${product.price.toStringAsFixed(2)}', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}