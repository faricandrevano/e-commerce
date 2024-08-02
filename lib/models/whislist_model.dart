class WhislistModel {
  const WhislistModel(
      {required this.title,
      required this.category,
      required this.description,
      required this.id,
      required this.image,
      required this.price,
      required this.rating});
  final String id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  final double rating;
  factory WhislistModel.fromJson(Map<String, dynamic> json) {
    return WhislistModel(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      price: json['price'],
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
    };
  }
}
