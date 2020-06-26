import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        decoration: InputDecoration(
          hintText: "Search for a recipe....",
          filled: true,
          prefixIcon: Icon(Icons.room_service, size: 28.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => print('cleared'),
          ),
        ),
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
            height: orientation==Orientation.portrait ?300.0 :200,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body: buildNoContent(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}
