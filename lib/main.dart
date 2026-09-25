import 'package:flutter/material.dart';
import 'controllers/search_controller.dart';
import 'repositories/product_repository.dart';
import 'screens/search_screen.dart';
import 'services/product_api.dart';

void main() {
  final api = ProductApi();
  final repository = ProductRepository(api);
  final controller = SearchController(repository);

  runApp(MyApp(controller: controller));
}

class MyApp extends StatelessWidget {
  final SearchController controller;

  const MyApp({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buscador de productos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: SearchScreen(controller: controller),
    );
  }
}
