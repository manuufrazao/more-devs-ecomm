import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../controllers/carrinho_controller.dart';
import 'carrinho_page.dart';
import 'category_products_page.dart'; // <-- ADICIONA ESSE IMPORT
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _bannerController = PageController();
  final HomeController _homeController = HomeController();
  final CarrinhoController _carrinho = CarrinhoController();

  @override
  void initState() {
    super.initState();
    _homeController.getCategories();
    _homeController.getProduct();
    _homeController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _homeController.dispose();
    super.dispose();
  }

  void _abrirModalProduto(Map<String, dynamic> p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(p['imageUrl'], height: 180, width: double.infinity, fit: BoxFit.cover, headers: const {"User-Agent": "Mozilla/5.0"})),
            const SizedBox(height: 16),
            Text(p['name'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('R\$ ${p['price']}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[700])),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { setState(() => _carrinho.addProduct(p)); Navigator.pop(context); }, child: const Text("Adicionar no carrinho", style: TextStyle(color: Colors.white)))),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
          Stack(children: [
            IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => CarrinhoPage(carrinho: _carrinho))).then((_) => setState(() {})); }),
            if (_carrinho.itemCount > 0) Positioned(right: 8, top: 8, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle), child: Text('${_carrinho.itemCount}', style: const TextStyle(color: Colors.white, fontSize: 10)))),
          ]),
        ]),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
            const Text('Olá, Manu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(height: 130, child: PageView(controller: _bannerController, children: [
              Container(decoration: BoxDecoration(color: const Color(0xFFE8EEF2), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(16), child: Text('Aproveite as ofertas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))), Expanded(flex: 2, child: ClipRRect(borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)), child: Image.network('https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400', height: 130, fit: BoxFit.cover))) ])),
              Container(height: 130, decoration: BoxDecoration(color: const Color(0xFFE8EEF2), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(16), child: Text('Experimente\nagora!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))), Expanded(flex: 2, child: ClipRRect(borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)), child: Image.network('https://images.unsplash.com/photo-1504545102780-26774c1bb073?w=400', height: 130, width: double.infinity, fit: BoxFit.cover))) ])),
            ])),
            const SizedBox(height: 12),
            Center(child: SmoothPageIndicator(controller: _bannerController, count: 2, effect: const WormEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Colors.black))),
            const SizedBox(height: 24),
            const Text('Categorias', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),
            // CATEGORIAS - AGORA ABRE A TELA DE PESQUISA IGUAL DA FOTO
            SizedBox(height: 90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _homeController.categories.length, itemBuilder: (c, i) {
              final cat = _homeController.categories[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryProductsPage(
                        categoryName: cat.name,
                        homeController: _homeController,
                      ),
                    ),
                  );
                },
                child: Container(width: 75, margin: const EdgeInsets.only(right: 16), child: Column(children: [
                  CircleAvatar(radius: 30, backgroundColor: const Color.fromARGB(255, 255, 208, 99), backgroundImage: NetworkImage(cat.imageUrl)),
                  const SizedBox(height: 6),
                  Text(cat.name, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                ])),
              );
            })),
            const SizedBox(height: 16),
            const Text('Produtos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 12),
            Skeletonizer(enabled: _homeController.productViewState == ProductViewState.loading, child: SizedBox(height: 220, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: _homeController.produtosFiltrados.length, itemBuilder: (c, i) {
              final p = _homeController.produtosFiltrados[i];
              return InkWell(
                onTap: () => _abrirModalProduto({'name': p.name, 'imageUrl': p.imageUrl, 'brand': p.brand, 'price': p.price}),
                child: Container(width: 150, margin: const EdgeInsets.only(right: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(p.imageUrl, height: 130, width: 150, fit: BoxFit.cover, headers: const {"User-Agent": "Mozilla/5.0"})),
                  const SizedBox(height: 8),
                  Text(p.brand, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('R\$ ${p.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ])),
              );
            }))),
          ]),
      ),
    );
  }
}