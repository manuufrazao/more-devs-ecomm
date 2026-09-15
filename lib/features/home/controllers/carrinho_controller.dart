import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String brand;
  Product({required this.name, required this.price, required this.imageUrl, required this.brand});
}

class CarrinhoItem {
  final Product product;
  int quantity;
  CarrinhoItem({required this.product, this.quantity = 1});
}

class CarrinhoController extends ChangeNotifier {
  List<CarrinhoItem> items = [];

  void addProduct(dynamic productData) {
    Product product;
    if (productData is Map<String, dynamic>) {
      product = Product(
        name: productData['name']?? '',
        price: (productData['price'] as num?)?.toDouble()?? 0.0,
        imageUrl: productData['imageUrl']?? '',
        brand: productData['brand']?? '',
      );
    } else if (productData is Product) {
      product = productData;
    } else {
      return;
    }
    final index = items.indexWhere((i) => i.product.name == product.name);
    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(CarrinhoItem(product: product));
    }
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }

  int get itemCount {
    int c = 0;
    for (var i in items) { c += i.quantity; }
    return c;
  }

  double get total {
    double s = 0;
    for (var i in items) { s += i.product.price * i.quantity; }
    return s;
  }
}