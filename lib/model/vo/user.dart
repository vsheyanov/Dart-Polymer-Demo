library demo.wrike.model.vo.user;

import 'package:polymer/polymer_micro.dart';
import 'package:polymer/polymer.dart';

class User extends Object with JsProxy{

  @reflectable
  String firstName;

  @reflectable
  String lastName;

  @reflectable
  String get fullName => '$firstName $lastName';

  @reflectable
  void set fullName (String value){
    var names = value.split(' ');

    firstName = names[0];
    lastName = names[1];
  }

  User (this.firstName, this.lastName);

  User.fromJson(userObj){
    this.firstName = userObj['firstName'];
    this.lastName = userObj['lastName'];
  }

  //TODO automate
  Map toJson() => {
    'firstName' : firstName,
    'lastName' : lastName
  };
}