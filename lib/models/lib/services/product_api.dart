import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApi {
  static const String baseUrl = 'https://dummyjson.com/products/search';

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'q': query,
        'limit': '20',
      },
    );

    final response = await http.get(uri).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode != 200) {
      throw Exception('Error del servidor');
    }

    final data = jsonDecode(response.body);

    return List<Map<String, dynamic>>.from(
      data['products'] ?? [],
    );
  }
}