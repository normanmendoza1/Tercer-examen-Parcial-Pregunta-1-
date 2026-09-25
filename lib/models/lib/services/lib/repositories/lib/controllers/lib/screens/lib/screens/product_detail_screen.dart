import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  product.thumbnail,
                  height: 220,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 100),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text('Categoría: ${product.category}'),
            Text('Marca: ${product.brand}'),
            Text('Precio: \$${product.price.toStringAsFixed(2)}'),
            Text(
              'Descuento: ${product.discountPercentage.toStringAsFixed(1)}%',
            ),
            Text('Calificación: ${product.rating.toStringAsFixed(1)}'),
            Text('Stock: ${product.stock}'),
            const SizedBox(height: 20),
            Text(
              'Descripción',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
