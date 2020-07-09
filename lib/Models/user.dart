class User {

  final String uid;
  
  User({ this.uid });

}
class UserData {

  final String brewName;
  final String name;
  final int strength;
  final String sugars;
  final String uid;

  UserData({this.uid,this.brewName,this.sugars,this.strength,this.name});
}