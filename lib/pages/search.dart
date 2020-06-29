import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reteteblanao/models/recipe.dart';
import 'package:reteteblanao/models/user.dart';
import 'package:reteteblanao/pages/home.dart';
import 'package:reteteblanao/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> recipes =
        recipesRef.where("title", isEqualTo: query).getDocuments();
    setState(() {
      searchResultsFuture = recipes;
    });
  }

  clearSearch() {
    print('tapped');
    searchController.clear();
    setState(() {
      searchResultsFuture = null;
    });
  }

  @override
  void dispose() {
    searchResultsFuture = null;
    super.dispose();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search for a recipe....",
          filled: true,
          prefixIcon: Icon(Icons.room_service, size: 28.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
        child: Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/recipe.svg',
            height: orientation == Orientation.portrait ? 300.0 : 200,
          ),
          Text(
            'Find Recipes',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 60.0),
          )
        ],
      ),
    ));
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

        List<RecipeResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          Recipe recipe = Recipe.fromDocument(doc);
          RecipeResult searchResult = RecipeResult(recipe);
          searchResults.add(searchResult);
        });
        return ListView(children: searchResults);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class RecipeResult extends StatelessWidget {
  final Recipe recipe;

  RecipeResult(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => print('tapped'),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(recipe.photoUrl),
                ),
                title: Text(
                  recipe.title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              height: 2.0,
              color: Colors.white54,
            ),
          ],
        ));
  }
}
