class Product {
  String name;
  String image;
  double price;
  int quantity;
  bool fav = false;

  Product({
    this.name = '',
    this.image = '',
    this.price = 0.0,
    this.quantity = 1,
  });

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) quantity--;
  }

  void toggleFav() {
    fav = !fav;
  }
}
