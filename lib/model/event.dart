import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Event{
  final String title;
  final String desc;
  final String imageUrl;

  Event({
    required this.title,
    required this.desc,
    required this.imageUrl
  });

 

  factory Event.fromJson(Map<String,dynamic>json){
    return Event(
      title: json['title'], 
      desc: json['desc'], 
      imageUrl: json['imageUrl'],);
  }
  
}