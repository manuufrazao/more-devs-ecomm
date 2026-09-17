import 'package:flutter/material.dart';
import '../controllers/carrinho_controller.dart';

class CarrinhoPage extends StatefulWidget {
  final CarrinhoController carrinho;
  const CarrinhoPage({super.key, required this.carrinho});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('Carrinho', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: widget.carrinho,
        builder: (_, __) {
          final itens = widget.carrinho.itens.values.toList();
          if (itens.isEmpty) return const Center(child: Text('Seu carrinho está vazio'));

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: itens.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (c, i) {
                    final item = itens[i];
                    final qtd = item['quantidade'] as int;
                    return Row(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(item['image'], width: 70, height: 70, fit: BoxFit.cover)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item['brand']?? '', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                          Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                          const Text('R\$ 7,99', style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              if (qtd <= 1)
                                TextButton(onPressed: () => setState(() => widget.carrinho.remover(item['id'])), child: const Text('Excluir', style: TextStyle(color: Colors.red, fontSize: 12)))
                              else
                                IconButton(icon: const Icon(Icons.remove, size: 18), onPressed: () => setState(() => widget.carrinho.decrementar(item['id']))),
                              Text('$qtd', style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(icon: const Icon(Icons.add, size: 18), onPressed: () => setState(() => widget.carrinho.incrementar(item['id']))),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
                child: SizedBox(
                  width: double.infinity, height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () {},
                    child: Text('Finalizar - R\$ ${widget.carrinho.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}