import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:more_devs_do_zero/features/home/models/category_model.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/shared/mocks.dart';

enum CategoriesViewState { loading, success, error }
enum ProductViewState { loading, success, error }

class HomeController extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];

  CategoriesViewState categoriesState = CategoriesViewState.loading;
  ProductViewState productViewState = ProductViewState.loading;

  String _categoriaSelecionada = 'Todos';
  String get categoriaSelecionada => _categoriaSelecionada;

  List<Product> get produtosFiltrados {
    if (_categoriaSelecionada == 'Todos') return products;
    return products.where((p) => p.category == _categoriaSelecionada).toList();
  }

  void changeCategoriesState(CategoriesViewState state) {
    categoriesState = state;
    notifyListeners();
  }

  void changeProductsState(ProductViewState state) {
    productViewState = state;
    notifyListeners();
  }

  void selecionarCategoria(String nome) {
    _categoriaSelecionada = nome;
    notifyListeners();
  }

  Future<void> getCategories() async {
    changeCategoriesState(CategoriesViewState.loading);
    await Future.delayed(Duration(seconds: 3));
    try {
      categories = categoriesJson.map((item) {
        return Category.fromJson(item);
      }).toList();
      changeCategoriesState(CategoriesViewState.success);
    } catch (e) {
      changeCategoriesState(CategoriesViewState.error);
    }
  }

  Future<void> getProduct() async {
    changeProductsState(ProductViewState.loading);
    await Future.delayed(Duration(seconds: 3));
    try {
      products = productsJson.map((item) {
        return Product.fromJson(item);
      }).toList();
      changeProductsState(ProductViewState.success);
    } catch (e) {
      changeProductsState(ProductViewState.error);
    }
  }

  // QUANDO QUISER USAR API DE VERDADE, É SÓ USAR ESSE AQUI NO LUGAR DO DE CIMA
  Future<void> getProductDaApi() async {
    changeProductsState(ProductViewState.loading);
    try {
      final url = 'https://jsonplaceholder.typicode.com/posts';
      final resposta = await http.get(Uri.parse(url));
      final listaJson = jsonDecode(resposta.body) as List;
      products = listaJson.map((item) => Product.fromJson(item)).toList();
      changeProductsState(ProductViewState.success);
    } catch (e) {
      changeProductsState(ProductViewState.error);
    }
  }
}