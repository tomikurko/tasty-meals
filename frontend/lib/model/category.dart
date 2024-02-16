class Category {
  final int id;
  final String name;
  final int? numRecipes;

  Category.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        name = jsonData['name'],
        numRecipes = jsonData['recipe_count'];
}
