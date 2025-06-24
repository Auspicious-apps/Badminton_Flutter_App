// lib/models/product.dart
class Product {
  final String name;
  final String price;
  final String oldPrice;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
  });

  // Optional: Add fromMap and toMap for serialization if needed
  factory Product.fromMap(Map<String, String> map) {
    return Product(
      name: map['name']!,
      price: map['price']!,
      oldPrice: map['oldPrice']!,
      image: map['image']!,
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'price': price,
      'oldPrice': oldPrice,
      'image': image,
    };
  }
}