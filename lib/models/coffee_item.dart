class CoffeeItem {
  final int id;
  final String title;
  final String description;
  final double price; // Add price field
  final String imageUrl;
  final String details;

  CoffeeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.details,
  });

  factory CoffeeItem.fromJson(Map<String, dynamic> json) {
    return CoffeeItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(), // Parse price as double
      imageUrl: json['imageUrl'],
      details: json['details'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'details': details,
    };
  }
}




