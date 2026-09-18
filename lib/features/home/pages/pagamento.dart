import 'package:flutter/material.dart';
import '../controllers/carrinho_controller.dart';

class PagamentoPage extends StatelessWidget {
  final CarrinhoController carrinho;
  const PagamentoPage({super.key, required this.carrinho});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF1F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Finalizar pedido",
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total do pedido", style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  const SizedBox(height: 2),
                  Text(
                    "R\$ ${carrinho.total.toStringAsFixed(2).replaceAll('.', ',')}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // lista dos itens que estão no carrinho
           ...carrinho.itens.values.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item['quantidade']}x ${item['name']}", style: const TextStyle(fontSize: 13)),
                    Text("R\$ ${(7.99 * (item['quantidade'] as int)).toStringAsFixed(2).replaceAll('.', ',')}",
                         style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              );
            }),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  // ainda incompleto - vai implementar o pagamento aqui depois
                },
                child: const Text("Confirmar pedido", style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}