class ProductItemResponse {
  final String description;
  final String title;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  const ProductItemResponse({
    required this.description,
    required this.imageUrl,
    required this.isFavorite,
    required this.price,
    required this.title,
  });
}
