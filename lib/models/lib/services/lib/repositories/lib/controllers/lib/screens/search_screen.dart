import 'package:flutter/material.dart';
import '../controllers/search_controller.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final SearchController controller;

  const SearchScreen({
    super.key,
    required this.controller,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  void search() {
    widget.controller.search(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de productos'),
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (_) => search(),
                        decoration: const InputDecoration(
                          hintText: 'Buscar producto',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: search,
                      child: const Text('Buscar'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildContent(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (widget.controller.state) {
      case SearchState.initial:
        return const Center(
          child: Text('Escribe un producto para buscar.'),
        );

      case SearchState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case SearchState.empty:
        return const Center(
          child: Text('No se encontraron productos.'),
        );

      case SearchState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 50),
              const SizedBox(height: 10),
              Text(widget.controller.errorMessage),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: search,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        );

      case SearchState.success:
        return ListView.builder(
          itemCount: widget.controller.products.length,
          itemBuilder: (context, index) {
            final Product product = widget.controller.products[index];

            return ListTile(
              leading: product.thumbnail.isEmpty
                  ? const Icon(Icons.image)
                  : Image.network(
                      product.thumbnail,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image),
                    ),
              title: Text(product.title),
              subtitle: Text(product.category),
              trailing: Text('\$${product.price.toStringAsFixed(2)}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: product,
                    ),
                  ),
                );
              },
            );
          },
        );
    }
  }
}
