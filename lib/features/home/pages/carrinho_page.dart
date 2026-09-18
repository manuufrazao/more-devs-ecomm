import 'package:flutter/material.dart';
import '../controllers/carrinho_controller.dart';
import 'pagamento.dart';

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
      backgroundColor: const Color(0xFFFFF1F8), // rosa clarinho do Figma
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF1F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Carrinho",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.carrinho.itens.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final id = widget.carrinho.itens.keys.elementAt(index);
                final item = widget.carrinho.itens[id]!;
                final qtd = item['quantidade'] as int;

                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image'],
                          width: 50, height: 50, fit: BoxFit.cover,
                          errorBuilder: (_,__,___) => Container(width: 50, height: 50, color: Colors.grey[200]),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                Text("R\$ 12,19", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                              ],
                            ),
                            Text("Restaurante da Serra", style: TextStyle(fontSize: 9, color: Colors.grey[500])),
                            const SizedBox(height: 6),
                            // os botõezinhos pretos - e +
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _botaoPreto(Icons.remove, () {
                                  setState(() {
                                    if (qtd <= 1) { widget.carrinho.remover(id); }
                                    else { widget.carrinho.decrementar(id); }
                                  });
                                }),
                                Container(
                                  width: 22, alignment: Alignment.center,
                                  child: Text("$qtd", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                                _botaoPreto(Icons.add, () {
                                  setState(() => widget.carrinho.incrementar(id));
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // PARTE DE BAIXO - TOTAL + CONTINUAR
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total do pedido", style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                const SizedBox(height: 2),
                Text("R\$ ${widget.carrinho.total.toStringAsFixed(2).replaceAll('.', ',')}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    onPressed: () {
                      if (widget.carrinho.itens.isEmpty) return;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PagamentoPage(carrinho: widget.carrinho)));
                    },
                    child: const Text("Continuar", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoPreto(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 22, height: 22,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }
}