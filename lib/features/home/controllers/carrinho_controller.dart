import 'package:flutter/material.dart';

class CarrinhoController extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _itens = {};

  Map<String, Map<String, dynamic>> get itens => _itens;
  int get quantidadeTotal => _itens.values.fold(0, (s, e) => s + (e['quantidade'] as int));
  int get itemCount => quantidadeTotal;
  double get total => _itens.values.fold(0.0, (s, e) => s + 7.99 * (e['quantidade'] as int));

  void addProduct(Map<String, dynamic> product) {
    // BLINDAGEM: se não tiver id, usa o nome como id
    final rawId = product['id']?? product['name'];
    final id = rawId.toString();

    if (_itens.containsKey(id)) {
      incrementar(id);
    } else {
      _itens[id] = {
        'id': id,
        'name': (product['name']?? 'Produto').toString(),
        'brand': (product['brand']?? 'Akatsu').toString(),
        'image': (product['image']?? product['imageUrl']?? '').toString(),
        'quantidade': 1,
      };
      notifyListeners();
    }
  }

  void incrementar(String id) {
    if (_itens.containsKey(id)) {
      _itens[id]!['quantidade'] = (_itens[id]!['quantidade'] as int) + 1;
      notifyListeners();
    }
  }

  void decrementar(String id) {
    if (_itens.containsKey(id)) {
      final qtd = _itens[id]!['quantidade'] as int;
      if (qtd > 0) {
        _itens[id]!['quantidade'] = qtd - 1;
        notifyListeners();
      }
    }
  }

  void remover(String id) {
    _itens.remove(id);
    notifyListeners();
  }
}