import 'package:flutter/material.dart';
import '../controllers/carrinho_controller.dart';

class ProductDetailPage {
  static void show(BuildContext context, Map<String, dynamic> product, CarrinhoController carrinho) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 350,
          child: ListView(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(product['imageUrl'], height: 150, fit: BoxFit.cover)),
              const SizedBox(height: 12),
              Text(product['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('R\$ ${product['price']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    carrinho.addProduct(product);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product['name']} adicionado!')),
                    );
                  },
                  child: const Text('Adicionar no carrinho', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}