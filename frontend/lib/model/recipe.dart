class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> steps;

  Recipe.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        name = jsonData['name'],
        ingredients = (jsonData['ingredients'] as List)
            .map((item) => item['description'] as String)
            .toList(),
        steps = (jsonData['steps'] as List)
            .map((item) => item['description'] as String)
            .toList();
}
