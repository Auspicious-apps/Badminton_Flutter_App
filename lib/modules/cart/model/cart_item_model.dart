class CartItem {
  String productId;
  String productName;
  String imageUrl;
  double price;
  double discountedPrice;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    this.discountedPrice = 0.0,
    this.quantity = 1
  });
}
