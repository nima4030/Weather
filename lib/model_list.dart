import 'dart:convert';

class Model_list{
  List<String> city,weather;
  List<double> temp,temp_max,temp_min;


  Model_list({ this.city,  this.weather,  this.temp,  this.temp_max,
       this.temp_min}); //late List list;




  factory Model_list.fromJson(List list){



    return Model_list(
        city: [list[0]['name'],list[1]['name'],list[2]['name'],list[3]['name'],list[4]['name'],list[5]['name'],list[6]['name'],list[7]['name'],list[8]['name'],list[9]['name']],
        weather: [list[0]['weather'][0]['description'],list[1]['weather'][0]['description'],list[2]['weather'][0]['description'],list[3]['weather'][0]['description'],list[4]['weather'][0]['description'],list[5]['weather'][0]['description'],list[6]['weather'][0]['description'],list[7]['weather'][0]['description'],list[8]['weather'][0]['description'],list[9]['weather'][0]['description']],
        temp: [list[0]['main']['temp']-272.15,list[1]['main']['temp']-272.15,list[2]['main']['temp']-272.15,list[3]['main']['temp']-272.15,list[4]['main']['temp']-272.15,list[5]['main']['temp']-272.15,list[6]['main']['temp']-272.15,list[7]['main']['temp']-272.15,list[8]['main']['temp']-272.15,list[9]['main']['temp']-272.15],
        temp_min: [list[0]['main']['temp_min']-272.15,list[1]['main']['temp_min']-272.15,list[2]['main']['temp_min']-272.15,list[3]['main']['temp_min']-272.15,list[4]['main']['temp_min']-272.15,list[5]['main']['temp_min']-272.15,list[6]['main']['temp_min']-272.15,list[7]['main']['temp_min']-272.15,list[8]['main']['temp_min']-272.15,list[9]['main']['temp_min']-272.15],
        temp_max: [list[0]['main']['temp_max']-272.15,list[1]['main']['temp_max']-272.15,list[2]['main']['temp_max']-272.15,list[3]['main']['temp_max']-272.15,list[4]['main']['temp_max']-272.15,list[5]['main']['temp_max']-272.15,list[6]['main']['temp_max']-272.15,list[7]['main']['temp_max']-272.15,list[8]['main']['temp_max']-272.15,list[9]['main']['temp_max']-272.15]







      /*city0: json0['name'],temp0: json0['main']['temp'],temp_max0: json0['main']['temp_max'],temp_min0: json0['main']['temp_min'],weather0:json0['weather'][0]['description'],*/

    );
    }
  /*  static get_list(list){


       var t=0;
        List<Map<String,dynamic>> ll=[];
        while(t<list.length){
          Map<String,dynamic> map=jsonDecode(list[t]);
         // print("//${map['name']}+ : +${map['main']['temp']}//");
          ll.add(map);


          t++;
        }
        print(list.runtimeType);
        return Model_list.fromJson(ll);

     }*/
}