import 'package:flutter/widgets.dart';
import 'package:more_devs_do_zero/features/cart/models/cart_item_model.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
 
class CarrinhoController extends ChangeNotifier {
  final List<CarrinhoItem> items = [];
 
  // quantidade total de itens (soma das quantidades, não da qtd de produtos diferentes)
  int get itemCount {
    return items.fold(0, (total, item) => total + item.quantity);
  }
 
  // soma do preço de tudo que está no carrinho
  double get total {
    return items.fold(0, (total, item) => total + item.subtotal);
  }
 
  void addProduct(Product product) {
    // verifica se o produto já está no carrinho
    final index = items.indexWhere((item) => item.product.name == product.name);
 
    if (index >= 0) {
      // já existe: só aumenta a quantidade
      items[index].quantity++;
    } else {
      // não existe: adiciona um novo item com quantidade 1
      items.add(CarrinhoItem(product: product));
    }
 
    notifyListeners();
  }
 
  void removeProduct(Product product) {
    final index = items.indexWhere((item) => item.product.name == product.name);
 
    if (index >= 0) {
      if (items[index].quantity > 1) {
        // ainda tem mais de 1: só diminui a quantidade
        items[index].quantity--;
      } else {
        // era o último: remove o item inteiro da lista
        items.removeAt(index);
      }
      notifyListeners();
    }
  }
 
  void removeItemCompletely(Product product) {
    items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }
 
  void clear() {
    items.clear();
    notifyListeners();
  }
}