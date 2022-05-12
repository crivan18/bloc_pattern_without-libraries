class ItemModel {
  final int id;
  final String name;
  final String color;
  final String pantoneValue;
  bool addedToCart;
  final double price;

  ItemModel({
    required this.id,
    required this.name,
    required this.color,
    required this.pantoneValue,
    required this.price,
    this.addedToCart = false,
  });

  void toggleAdded() {
    addedToCart = !addedToCart;
  }
}
