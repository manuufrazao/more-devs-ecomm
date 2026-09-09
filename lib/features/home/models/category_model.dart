class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name'], imageUrl: json['imageUrl']);
  }
}

class Product {
  final String name;
  final String imageUrl;

  final String brand;
  final double price;

  Product({required this.name, required this.imageUrl, required this.brand, required this.price});

factory Product.fromJson(Map<String, dynamic> json) {
    return Product(name: json['name'], imageUrl: json['imageUrl'], brand: json['brand'],  price: json['price']);
    }
}

