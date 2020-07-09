import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/user.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey =GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];
  final List<String> brewNames = ['Cappucino','Latte','Expresso','Americano','Filter Coffee','Decaf'];

  //form values
  String _currentName;
  String _currentBrewName;
  String _currentSugars = '0';
  int _currentStrength = 500;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                //Dropdown for Brew Name
                SizedBox(height:20),
                DropdownButtonFormField( 
                  value: _currentBrewName ?? userData.brewName,
                  decoration: textInputDecoration.copyWith(hintText: 'Brew Type'),
                  items: brewNames.map((brewName){
                    return DropdownMenuItem(
                      value: brewName,
                      child: Text('$brewName')
                    );
                  }).toList(),
                  onChanged: (val) => setState( () => _currentBrewName = val ),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val ),
                ),
                SizedBox(height: 10.0),
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars, 
                        _currentBrewName ?? userData.brewName, 
                        _currentStrength ?? userData.strength, 
                        _currentName ?? userData.name
                      );
                      Navigator.pop(context);
                    }
                    print(_currentName);
                    print(_currentSugars);
                    print(_currentStrength);
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}