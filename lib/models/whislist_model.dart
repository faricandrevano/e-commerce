class WhislistModel {
  const WhislistModel(
      {required this.title,
      required this.category,
      required this.description,
      required this.id,
      required this.image,
      required this.price,
      required this.qty,
      required this.rating});
  final String id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  final double qty;
  factory WhislistModel.fromJson(Map<String, dynamic> json) {
    return WhislistModel(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
      qty: json['qty'],
      rating: json['rating'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'image': image,
      'price': price,
      'rating': rating,
      'qty': qty,
    };
  }
}
