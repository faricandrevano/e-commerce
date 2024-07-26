class CartModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  final double qty;

  CartModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.image,
      required this.price,
      required this.rating,
      required this.qty});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        price: json['price'].toDouble(),
        rating: json['rating']['rate'].toDouble(),
        qty: json['qty'].toDouble());
  }
}
