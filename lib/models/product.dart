class Product {
  dynamic id;
  late String quantity;
  late String title;
  late String date;

  Product(this.title, this.quantity, this.date);

  Product.fromMap(Map map) {
    id = map["id"];
    quantity = map["quantity"];
    title = map["title"];
    date = map["date"];
  }

  Map<String, Object?> toMap() {
    Map<String, dynamic> map = {
      "quantity": quantity,
      "title": title,
      "date": date,
    };

    if (id != null) map["id"] = id;

    return map;
  }
}
