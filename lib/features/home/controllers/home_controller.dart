import 'package:flutter/widgets.dart';
import 'package:more_devs_do_zero/features/home/models/category_model.dart';
import 'package:more_devs_do_zero/shared/mocks.dart';

enum CategoriesViewState { loading, success, error }
enum ProductViewState { loading, success, error }

class HomeController extends ChangeNotifier {
  List<Category> categories = [];
List<Product> products = [];




  CategoriesViewState categoriesState = CategoriesViewState.loading;
ProductViewState productViewState = ProductViewState.loading;
  void changeCategoriesState(CategoriesViewState state) {
    categoriesState = state;
    notifyListeners();
  }

void changeProductsState(ProductViewState state) {
    productViewState = state;
    notifyListeners();
  }
  Future<void> getCategories() async {
    changeCategoriesState(CategoriesViewState.loading);
    //simula o delay da API
    await Future.delayed(Duration(seconds: 3));
    try {
      categories = categoriesJson.map((item) {
        return Category.fromJson(item);
      }).toList();

      changeCategoriesState(CategoriesViewState.success);
    } catch (e) {
      //caso der erro na deserialização, emite o erro para a tela tratar
      changeCategoriesState(CategoriesViewState.error);
      
    }
  }
Future<void> getProduct() async {
    changeProductsState(ProductViewState.loading);
    //simula o delay da API
    await Future.delayed(Duration(seconds: 3));
    try {
      products = productsJson.map((item) {
        return Product.fromJson(item);
      }).toList();

      changeProductsState(ProductViewState.success);
    } catch (e) {
      //caso der erro na deserialização, emite o erro para a tela tratar
      changeProductsState(ProductViewState.error);
      
    }
  }

}

