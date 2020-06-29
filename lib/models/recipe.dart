import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String id;
  final String title;
  final List<dynamic> ingredients;
  final String description;
  final String photoUrl;

  Recipe(
      {this.id, this.title, this.ingredients, this.description, this.photoUrl});

  factory Recipe.fromDocument(DocumentSnapshot doc) {
    return Recipe(
        id: doc['id'],
        title: doc['title'],
        ingredients: doc['ingredients'],
        description: doc['description'],
        photoUrl: doc['photoUrl']);
  }
}
