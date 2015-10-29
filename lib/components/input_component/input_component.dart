@HtmlImport('input_component.html')
library demo.wrike.component.inputcomponent;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html';

@PolymerRegister('input-component')
class InputComponent extends PolymerElement{

  factory InputComponent() => new Element.tag('input-component');
  InputComponent.created() : super.created();

}

