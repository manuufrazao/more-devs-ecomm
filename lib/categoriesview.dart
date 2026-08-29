import 'package:flutter/material.dart';

final List<Map<String, dynamic>> categoriesJson = [
  {'name': 'Frutas', 'imageUrl': 'https://i.postimg.cc/SNX7hc6F/Image.png'},
  {'name': 'Verduras', 'imageUrl': 'https://i.postimg.cc/8PFBSLh2/Image-(1).png'},
  {'name': 'Padaria', 'imageUrl': 'https://i.postimg.cc/xTky2LvV/Image-1.png'},
  {'name': 'Importados', 'imageUrl': 'https://i.postimg.cc/Yq4fHQ6w/Image-2.png'},
];

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesJson.length,
        itemBuilder: (context, i) {
          final cat = categoriesJson[i];
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(cat['imageUrl']),
                ),
                const SizedBox(height: 6),
                Text(cat['name'], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}