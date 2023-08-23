class Product {
  String? pCategory;
  List<String>? pImgs;
  String? pQuantity;
  String? pRating;
  String? pName;
  String? vendorId;
  String? pDesc;
  String? pPrice;
  String? pSeller;
  List<String>? pColors;
  String? pSubcategory;
  List<String>? pWishlist;
  String? id;
  bool? pIsFeatured;

  Product(
      {required this.pCategory,
      required this.pImgs,
      required this.pQuantity,
      required this.pRating,
      required this.pName,
      required this.vendorId,
      required this.pDesc,
      required this.pPrice,
      required this.pSeller,
      required this.pColors,
      required this.pSubcategory,
      required this.pWishlist,
      required this.id,
      required this.pIsFeatured});

  Product.fromJson(Map<String, dynamic> json) {
    pCategory = json['p_category'];
    pImgs = json['p_imgs'].cast<String>();
    pQuantity = json['p_quantity'];
    pRating = json['p_rating'];
    pName = json['p_name'];
    vendorId = json['vendor_id'];
    id = json['id'];
    pIsFeatured = json['is_featured'];
    pDesc = json['p_desc'];
    pPrice = json['p_price'];
    pSeller = json['p_seller'];
    pColors = json['p_colors'].cast<String>();
    pSubcategory = json['p_subcategory'];
    pWishlist = json['p_wishlist'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_category'] = pCategory;
    data['p_imgs'] = pImgs;
    data['p_quantity'] = pQuantity;
    data['p_rating'] = pRating;
    data['p_name'] = pName;
    data['vendor_id'] = vendorId;
    data['id'] = id;
    data['is_featured'] = pIsFeatured;
    data['p_desc'] = pDesc;
    data['p_price'] = pPrice;
    data['p_seller'] = pSeller;
    data['p_colors'] = pColors;
    data['p_subcategory'] = pSubcategory;
    data['p_wishlist'] = pWishlist;
    return data;
  }
}
