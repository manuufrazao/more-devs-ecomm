import 'package:flutter/material.dart';
import '../controllers/carrinho_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final CarrinhoController carrinho;
  const ProductDetailPage({super.key, required this.product, required this.carrinho});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 567,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        Center(child: Container(margin: const EdgeInsets.only(top:12,bottom:12), width:40,height:4, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2)))),
        Padding(padding: const EdgeInsets.symmetric(horizontal:16), child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(product['imageUrl'], height:180, width:double.infinity, fit:BoxFit.cover))),
        const SizedBox(height:16),
        Padding(padding: const EdgeInsets.symmetric(horizontal:16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product['name'], style: const TextStyle(fontSize:20,fontWeight: FontWeight.bold)),
          Text(product['brand'], style: TextStyle(fontSize:13,color: Colors.grey)),
          const SizedBox(height:12),
          const Text('A acerola é uma fruta tropical conhecida pelo seu sabor refrescante, levemente ácido e naturalmente adocicado. Rica em vitamina C e muito versátil.', style: TextStyle(fontSize:13, height:1.4)),
          const SizedBox(height:16),
          Text('R\$ ${product['price'].toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontSize:18,fontWeight: FontWeight.bold)),
        ])),
        const Spacer(),
        Padding(padding: const EdgeInsets.all(16), child: SizedBox(width:double.infinity,height:48, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), onPressed: (){carrinho.addProduct(product); Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product['name']} adicionado!')));}, child: const Text('Adicionar no carrinho', style: TextStyle(fontWeight: FontWeight.bold))))),
      ]),
    );
  }
  static void show(BuildContext context, Map<String, dynamic> product, CarrinhoController carrinho){
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (c)=>ProductDetailPage(product: product, carrinho: carrinho));
  }
}