class Recipe {
  final String id;
  final String title;
  final String description;
  final List<int> fruitIds;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.fruitIds,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      fruitIds: List<int>.from(json['fruitIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fruitIds': fruitIds,
    };
  }
}