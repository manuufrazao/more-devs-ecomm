class Product {
  final String name;
  final String imageUrl;
  final String brand;
  final double price;
  final String category; // <--- ADICIONA ISSO

  Product({
    required this.name, 
    required this.imageUrl, 
    required this.brand, 
    required this.price,
    required this.category, // <--- ADICIONA ISSO
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'], 
      imageUrl: json['imageUrl'], 
      brand: json['brand'],  
      price: (json['price'] as num).toDouble(),
      category: json['category'] ?? 'Frutas', // <--- ADICIONA ISSO
    );
  }
}