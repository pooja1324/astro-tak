class Category {
  int id;
  String name;
  int price;
  String? description;
  List<String> suggestions;

  Category(this.id, this.name, this.price, this.description, this.suggestions);

  factory Category.fromJson(Map<String, dynamic> json) {
    List<String> suggestions = [];
    for (var element in (json['suggestions'] as List)) {
      suggestions.add(element as String);
    }
    return Category(json['id'] as int, json['name'] as String,
        json['price'] as int, json['description'], suggestions);
  }
}
