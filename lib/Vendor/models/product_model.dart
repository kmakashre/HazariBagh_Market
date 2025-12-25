class ProductModel {
  final String id;
  final String shopName;
  final String name;
  final double price;
  final int stock;
  final String category;
  final String description;
  final String imagePath; // local image

  ProductModel({
    required this.id,
    required this.shopName,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.description,
    required this.imagePath,
  });
}
