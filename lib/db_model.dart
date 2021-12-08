import 'package:flutter/material.dart';

class DB_Model{
  String city_name;
   int id;

  DB_Model({this.city_name,this.id});

  /*Model2*/ fromjson(json){
    return DB_Model(city_name: json['city_name'],id: json['id']);
  }
  Map<String,dynamic> tojson(){
    return {'city_name':city_name,
             'id':id};
  }
}