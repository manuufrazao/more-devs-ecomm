import 'package:more_devs_do_zero/features/home/models/product_model.dart';
 
class CarrinhoItem {
  final Product product;
  int quantity;
 
  CarrinhoItem({
    required this.product,
    this.quantity = 1,
  });
 
  double get subtotal => product.price * quantity;
}
 