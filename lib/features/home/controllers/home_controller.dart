import 'package:flutter/widgets.dart';
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

  // --- O QUE FALTAVA PRA FILTRAR ---
  String _categoriaSelecionada = 'Todos';
  String get categoriaSelecionada => _categoriaSelecionada;

  // get que retorna só os produtos da categoria clicada
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

  // método do botão que você falou
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
}