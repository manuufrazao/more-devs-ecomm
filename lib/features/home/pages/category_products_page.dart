import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../models/product_model.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryName;
  final HomeController homeController;

  const CategoryProductsPage({
    super.key,
    required this.categoryName,
    required this.homeController,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text.toLowerCase());
    });
    // já deixa filtrado pela categoria clicada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.homeController.selecionarCategoria(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    // pega os produtos da categoria + filtro da pesquisa
    List<Product> produtos = widget.homeController.produtosFiltrados.where((p) {
      if (_searchText.isEmpty) return true;
      return p.name.toLowerCase().contains(_searchText) ||
             p.brand.toLowerCase().contains(_searchText);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.categoryName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // BARRA DE PESQUISA IGUAL DA FOTO
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rabanete',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
              ),
            ),
            const SizedBox(height: 16),

            // GRID 2 POR LINHA IGUAL DA FOTO
            Expanded(
              child: GridView.builder(
                itemCount: produtos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final p = produtos[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(p.imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover, headers: const {"User-Agent": "Mozilla/5.0"}),
                      ),
                      const SizedBox(height: 8),
                      Text(p.brand, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                      Text(p.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      Text('R\$ ${p.price.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}