@HtmlImport('app.html')
library demo.wrike.component.mainapp;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'dart:html';
import 'dart:js';

import 'package:wrike_demo/components/input_component/input_component.dart';

import 'package:wrike_demo/model/service/MockService.dart';


@PolymerRegister('main-app')
class MainApp extends PolymerElement{

  MockService _dataService = new MockService();

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();

  @reflectable
  getData(e, target) async{
    print(await _dataService.getTask($['taskId'].value) );
  }
}

