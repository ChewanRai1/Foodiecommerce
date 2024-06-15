class CartItem {
  final String imageUrl;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

class CartModel {
  final List<CartItem> _items = [
    CartItem(
      imageUrl: 'assets/images/chicken_burger.png',
      name: 'Chicken Burger',
      price: 23.99,
    ),
    CartItem(
      imageUrl: 'assets/images/chicken_burger.png',
      name: 'Chicken Burger',
      price: 23.99,
    ),
  ];

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (total, item) => total + item.price * item.quantity);

  void incrementQuantity(int index) {
    _items[index].quantity++;
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    }
  }
}