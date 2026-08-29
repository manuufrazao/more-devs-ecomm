import 'package:flutter/material.dart';
import 'categoriesview.dart';

final List<Map<String, dynamic>> productsJson = [
  {'brand': 'Natural da terra', 'name': 'Rabanete', 'imageUrl': 'https://i.postimg.cc/8Pt82Qmf/Image-1.png', 'price': 10.99},
  {'brand': 'Akatsu', 'name': 'Acerola', 'imageUrl': 'https://i.postimg.cc/BQMWr9B8/Image.png', 'price': 7.99},
  {'brand': 'Natural da terra', 'name': 'Cogumelo', 'imageUrl': 'https://i.postimg.cc/RVP8P1vw/Image-2.png', 'price': 12.19},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget sectionHeader(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Olá, (Manuela)", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                // Banner aqui se tiver
                const SizedBox(height: 24),

             sectionHeader("Categorias", () => debugPrint("Ver todas categorias")),
sectionHeader("Produtos", () => debugPrint("Ver todos produtos")), 

                SizedBox(
                  height: 158,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productsJson.length,
                    itemBuilder: (context, i) {
                      final p = productsJson[i];
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(p['imageUrl'], width: 120, height: 100, fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 6),
                            Text(p['brand'], style: const TextStyle(fontSize: 9, color: Colors.grey)),
                            Text(p['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text("R\$ ${p['price']}", style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}