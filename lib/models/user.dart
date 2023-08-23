class User {
  String? cartCount;
  String? uid;
  String? wishlistCount;
  String? password;
  String? orderCount;
  String? imageUrl;
  String? name;
  String? email;

  User(
      {required this.cartCount,
      required this.uid,
      required this.wishlistCount,
      required this.password,
      required this.orderCount,
      required this.imageUrl,
      required this.name,
      required this.email});

  User.fromJson(Map<String, dynamic> json) {
    cartCount = json['cart_count'];
    uid = json['uid'];
    wishlistCount = json['wishlist_count'];
    password = json['password'];
    orderCount = json['order_count'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_count'] = cartCount;
    data['uid'] = uid;
    data['wishlist_count'] = wishlistCount;
    data['password'] = password;
    data['order_count'] = orderCount;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
