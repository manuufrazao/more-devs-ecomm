
import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/shared/mocks.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Olá, Manu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            AppBar(
  title: const Text('Produtos'),

),

            // BANNER
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EEF2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Aproveite as ofertas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
                        height: 130, fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // CATEGORIAS
            Row(
              children: [
                const Text('Categorias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 8),
                Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_right, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesJson.length,
                itemBuilder: (c, i) {
                  return Container(
                    width: 75,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color.fromARGB(255, 255, 208, 99),
                          backgroundImage: NetworkImage(categoriesJson[i]['imageUrl']),
                        ),
                        const SizedBox(height: 6),
                        Text(categoriesJson[i]['name'], style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

        
            Row(
              children: [
                const Text('Produtos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 8),
                Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_right, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Skeletonizer(
              enabled:true,
              
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsJson.length,
                  itemBuilder: (c, i) {
                    final p = productsJson[i];
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              p['imageUrl'],
                              height: 130, width: 150, fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(p['brand'], style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                          Text(p['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('R\$ ${p['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}