class Item {
  String itemId;
  String itemName;
  String itemDescription;
  double price;
  String imgUrl;

  Item(
      {required this.itemId,
      required this.itemName,
      required this.itemDescription,
      required this.price,
      required this.imgUrl});

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      "img_url": imgUrl,
      'item_description': itemDescription,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        itemId: map['item_id'],
        itemName: map['item_name'],
        itemDescription: map['item_description'],
        price: (map['price'] as num).toDouble(),
        imgUrl: map["img_url"]);
  }
}
