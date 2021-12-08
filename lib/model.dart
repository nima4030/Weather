import 'dart:convert';

class Model{
  String city,weather;
  double temp,temp_min,temp_max;
  int timezone;

 Model({ this.city,  this.temp, this.weather, this.temp_min, this.temp_max,this.timezone});


 factory Model.fromJson(Map<String, dynamic> json){
          return Model(city: json['name'],
                       temp: json['main']['temp'],
                       weather: json['weather'][0]['description'],
                       temp_min: json['main']['temp_min'],
                        temp_max: json['main']['temp_max'],
                         timezone: json['timezone']);
 }

}