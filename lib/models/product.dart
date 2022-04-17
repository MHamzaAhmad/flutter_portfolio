class Product {
  int id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  bool fav = false;

  Product({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.image = '',
    this.price = 0.0,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["title"],
        description: json["description"],
        image: json["image"],
        price: json["price"].toDouble(),
        quantity: 1,
      );

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
