import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastymeals/model/category.dart';
import 'package:tastymeals/model/recipe.dart';

class RecipesService {
  final _endpoint = 'http://52.138.179.120:8080/api/v1';
  //final _endpoint = 'http://localhost:8080/api/v1';

  Future<Category> getCategory(int categoryId) async {
    var response = await http.get(Uri.parse("$_endpoint/category/$categoryId"));

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<List<Category>> getAllCategories() async {
    var response = await http.get(Uri.parse("$_endpoint/categories"));
    List<dynamic> data = jsonDecode(response.body);

    return data.map((categoryData) => Category.fromJson(categoryData)).toList();
  }

  Future<List<Category>> getTopCategories() async {
    var response = await http.get(Uri.parse("$_endpoint/top-categories"));
    List<dynamic> data = jsonDecode(response.body);

    return data.map((categoryData) => Category.fromJson(categoryData)).toList();
  }

  Future<List<Recipe>> getRecipesByCategory(int categoryId) async {
    var response = await http.get(Uri.parse("$_endpoint/recipes")
        .replace(queryParameters: {'category': categoryId.toString()}));
    List<dynamic> data = jsonDecode(response.body);

    return data.map((recipeData) => Recipe.fromJson(recipeData)).toList();
  }

  Future<List<Recipe>> getRecipesByName(String name) async {
    var response = await http.get(Uri.parse("$_endpoint/recipes")
        .replace(queryParameters: {'nameContains': name}));
    List<dynamic> data = jsonDecode(response.body);

    return data.map((recipeData) => Recipe.fromJson(recipeData)).toList();
  }

  Future<Recipe> getRecipe(int recipeId) async {
    var response = await http.get(Uri.parse("$_endpoint/recipe/$recipeId"));

    return Recipe.fromJson(jsonDecode(response.body));
  }

  Future<Recipe> getLatestRecipe() async {
    var response = await http.get(Uri.parse("$_endpoint/latest-recipe"));

    return Recipe.fromJson(jsonDecode(response.body));
  }

  Future<Recipe> getRandomRecipe() async {
    var response = await http.get(Uri.parse("$_endpoint/random-recipe"));

    return Recipe.fromJson(jsonDecode(response.body));
  }
}
