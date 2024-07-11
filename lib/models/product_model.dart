class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating; // Tambahkan field rating

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.rating, // Tambahkan field rating
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
      rating: json['rating']['rate'].toDouble(), // Ambil rating dari JSON
    );
  }
}
