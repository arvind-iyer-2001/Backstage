import 'package:flutter/material.dart';
import 'package:flutter_firebase/Models/user.dart';
import 'package:provider/provider.dart';
import 'Home/home.dart';
import 'authenticate/authentication.dart';



class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final user =Provider.of<User>(context);
    
    print(user);
    if(user == null){
      return Authenticate();
    } else { 
      return Home();
    }  
  }
}