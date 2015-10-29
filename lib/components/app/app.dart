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

  @reflectable
  Task task = null;

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();

  @reflectable
  getData(e, target) async{
    task = await _dataService.getTask($['taskId'].value);

    set('task', task);
  }

  @reflectable
  updateData(e, target) {
    print(JSON.encode(task));

    HttpRequest.postFormData('/send', {'task' : JSON.encode(task)})
        .then((_){

        })
        .catchError((_){
          window.alert('Error happened');
        });
  }
}

