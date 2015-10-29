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

  User (this.firstName, this.lastName);
}