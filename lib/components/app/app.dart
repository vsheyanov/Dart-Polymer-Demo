@HtmlImport('app.html')
library demo.wrike.component.mainapp;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'dart:html';
import 'dart:convert';

import 'package:wrike_demo/components/input_component/input_component.dart';

import 'package:wrike_demo/model/service/MockService.dart';

import 'package:wrike_demo/model/vo/task.dart';


@PolymerRegister('main-app')
class MainApp extends PolymerElement{

  MockService _dataService = new MockService();

  @property
  final validators = {
    "fullName" : fullNameValidator,
    "numberValidator" : numberValidator
  };

  bool _isTaskModified = false;

  bool _allAssigneesValid = true;

  @property
  bool isTaskIdValid = true;

  @property
  bool isValidForUpdate = false;

  @reflectable
  Task task = null;

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();


  /////////////// getters / setters start ///////////////

  void _setTask (value){
    task = value;
    set('task', task);
  }

  void _setAllAssigneesValid (value){
    _allAssigneesValid = value;

    _setIsValidForUpdate();
  }



  void _setIsTaskModified(value){
    _isTaskModified = value;

    _setIsValidForUpdate();
  }

  void _setIsValidForUpdate(){
    isValidForUpdate = _isTaskModified && _allAssigneesValid;
    set('isValidForUpdate', isValidForUpdate);
  }
  /////////////// getters / setters end ///////////////


  ///////////// private methods start /////////////////

  _getData() async{
    _setIsTaskModified(false);
    _setAllAssigneesValid(true);

    _dataService.getTask($['taskId'].value).then((task){
      _setTask(task);
    });
  }

  ///////////// private methods start /////////////////

  ///////////// event handlers start //////////////////
  @reflectable
  getData(e, target) {
    _getData();
  }

  @reflectable
  void updateTaskIdValid(e, target){
    isTaskIdValid = e.currentTarget.isValid;
    set('isTaskIdValid', isTaskIdValid);
  }

  @reflectable
  void changeAssignee (e, [_]){
    _isTaskModified = true;
    _setIsValidForUpdate();

    var model = new DomRepeatModel.fromEvent(e);

    model.set('item.fullName', e.target.value);

    var allValid = true;
    List components = querySelectorAll(".assignees");
    components.forEach((component){
      if (!component.isValid)
        allValid = false;
    });

    _setAllAssigneesValid(allValid);
  }

  @reflectable
  updateData(e, target) {
    _setIsTaskModified(false);

    _dataService.updateTask(task)
        .catchError((_){
          _getData();
          window.alert('Error happened');
        });
  }
  ///////////// event handlers end //////////////////

  //////////////// validators start //////////////
  @reflectable
  static bool fullNameValidator(String value){
    RegExp regexp = new RegExp("^[a-zA-z]*\\s[a-zA-z]*\$");
    return regexp.firstMatch(value) != null;
  }

  @reflectable
  static bool numberValidator(String value){
    RegExp regexp = new RegExp("^[0-9]*\$");
    return regexp.firstMatch(value) != null;
  }
  //////////////// validators end /////////////////

}

