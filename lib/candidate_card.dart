@HtmlImport('candidate_card.html')
library candidate_card.candidate_card;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart';

import 'package:polymer_elements/paper_card.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/iron_flex_layout.dart';
import 'package:polymer_elements/iron_flex_layout/classes/iron_flex_layout.dart';
import 'package:polymer_elements/iron_media_query.dart';

@PolymerRegister('candidate-card', extendsTag: 'div')
class CandidateCard extends DivElement with PolymerMixin, PolymerBase {
  String _condidateName;
  String _imageUrl;

  @property String get candidateName => _condidateName;
  @reflectable
  void set candidateName(val) {
    _condidateName = val;
    notifyPath('candidateName', candidateName);
  }
  @property String get imageUrl => _imageUrl;
  @reflectable
  void set imageUrl(val) {
    _imageUrl = val;
    notifyPath('imageUrl', _imageUrl);
  }
  @property String linkUrl;
  @property bool noLink = false;

  @Property(observer: 'phoneScreenPortraitChanged') bool phoneScreenPortrait;
  @Property(observer: 'phoneScreenLandscapeChanged') bool phoneScreenLandscape;
  @Property(observer: 'tabletScreenPortraitChanged') bool tabletScreenPortrait;
  @Property(observer: 'tabletScreenLandscapeChanged') bool tabletScreenLandscape;
  @Property(observer: 'desktopScreenChanged') bool desktopScreen;

  CandidateCard.created() : super.created() {
    polymerCreated();
  }

  void attached() {
    HtmlElement contentChildren = ($['snippet'] as HtmlElement);//.children;
    if(contentChildren.querySelector('#name') != null) {
      List<String> classes = ($['name'] as HtmlElement).classes.map((e) => e.toString()).toList();
      candidateName = contentChildren.querySelector('#name').text.trim();
//      ($['name'] as HtmlElement).replaceWith(contentChildren.querySelector('#name'));

      querySelector('#name').classes.addAll(classes);
      $['snippet'].querySelector('#name').remove();
    }

    if(contentChildren.querySelector('#picture') != null) {
      List<String> classes = ($['picture'] as HtmlElement).classes.map((e) => e.toString()).toList();
      imageUrl = contentChildren.querySelector('#picture') is ImageElement ? contentChildren.querySelector('#picture').src : '';

//      ($['picture'] as HtmlElement).replaceWith(contentChildren.querySelector('#picture'));
      querySelector('#picture').classes.addAll(classes);
      $['snippet'].querySelector('#picture').remove();
    }

  }

  void ready() {
  }

  @reflectable
  void followLink([_, __]) {
    window.location.href = linkUrl;
  }

  @Observe('phoneScreenPortrait')
  void phoneScreenPortraitChanged([_, __]) {
    if(phoneScreenPortrait != null && phoneScreenPortrait) {
      ($['content'] as HtmlElement).classes
        ..remove('horizontal')
        ..add('vertical')
      ;

      ($['div-picture'] as HtmlElement).classes
        ..add('flex')
      ;
    }
  }


  @Observe('phoneScreenLandscape')
  void phoneScreenLandscapeChanged([_, __]) {
    if(phoneScreenLandscape != null && phoneScreenLandscape) {
      ($['content'] as HtmlElement).classes
        ..remove('horizontal')
        ..add('vertical')
      ;

      ($['div-picture'] as HtmlElement).classes
        ..add('flex')
      ;
    }
  }


  @Observe('tabletScreenPortrait')
  void tabletScreenPortraitChanged([_, __]) {
    if(tabletScreenPortrait != null && tabletScreenPortrait) {
      ($['content'] as HtmlElement).classes
        ..remove('horizontal')
        ..add('vertical')
      ;

      ($['div-picture'] as HtmlElement).classes
        ..add('flex')
      ;
    }
  }


  @Observe('tabletScreenLandscape')
  void tabletScreenLandscapeChanged([_, __]) {
    if(tabletScreenLandscape != null && tabletScreenLandscape) {
      ($['content'] as HtmlElement).classes
        ..remove('vertical')
        ..add('horizontal')
      ;

      ($['div-picture'] as HtmlElement).classes
        ..add('flex')
      ;
    }
  }

  @Observe('desktopScreen')
  void desktopScreenChanged([_, __]) {
    if(desktopScreen != null && desktopScreen) {
      ($['content'] as HtmlElement).classes
        ..remove('vertical')
        ..add('horizontal')
      ;
      ($['div-picture'] as HtmlElement).classes
        ..remove('flex')
      ;
    }
  }
}