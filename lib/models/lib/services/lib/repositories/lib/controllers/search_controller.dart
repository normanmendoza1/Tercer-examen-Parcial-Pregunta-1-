import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

enum SearchState {
  initial,
  loading,
  success,
  empty,
  error,
}

class SearchController extends ChangeNotifier {
  final ProductRepository repository;

  SearchController(this.repository);

  SearchState state = SearchState.initial;
  List<Product> products = [];
  String errorMessage = '';

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      products = [];
      state = SearchState.initial;
      notifyListeners();
      return;
    }

    state = SearchState.loading;
    errorMessage = '';
    notifyListeners();

    try {
      final result = await repository.search(query.trim());

      products = result;
      state = result.isEmpty
          ? SearchState.empty
          : SearchState.success;
    } catch (_) {
      products = [];
      errorMessage = 'No se pudo realizar la búsqueda.';
      state = SearchState.error;
    }

    notifyListeners();
  }
}
