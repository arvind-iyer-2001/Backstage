import 'package:flutter/material.dart';
import 'package:flutter_firebase/Services/auth.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/Screens/Home/brew_list.dart';
import 'package:flutter_firebase/Models/brew.dart';
import 'package:flutter_firebase/Screens/Home/settings_form.dart';


class Home extends StatelessWidget {

  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
          );
        }
      );
    }


    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('BREW CREW'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: (){
                _showSettingsPanel();
              }, 
              icon: Icon(Icons.settings), 
              label: Text('Settings'),
            ),

            FlatButton.icon(
              onPressed: ()async{
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person), 
              label: Text(
                "Sign Out"
              ),
            ),

            
          ],
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()
        ),
      ),
    );
  }
}
