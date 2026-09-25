import '../models/product.dart';
import '../services/product_api.dart';

class ProductRepository {
  final ProductApi api;

  ProductRepository(this.api);

  Future<List<Product>> search(String query) async {
    final data = await api.searchProducts(query);

    return data.map(Product.fromJson).toList();
  }
}
