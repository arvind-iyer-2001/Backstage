import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/Models/brew.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context);
    
    return ListView.builder(
      itemBuilder: (context, index){
        return BrewTile(brew: brews[index]);
      },
      itemCount: brews.length,
    );
  }
}