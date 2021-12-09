import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'model_list.dart';
import 'sqlite_db.dart';
import 'db_model.dart';





//void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        brightness: Brightness.dark,),
        home: Page_1(),
        debugShowCheckedModeBanner: false,
    );
  }
}
class Page_1 extends StatefulWidget {


  @override
  _Page_1State createState() => _Page_1State();
}

class _Page_1State extends State<Page_1> {
   Future<Model> futuremodel;
   Future<Model_list> futuremodel2;
   Future<Model> futuremodel3;
   Future<Model_list> futuremodel4;
   bool D=false;
   bool F=false;
  String Api_Key='6fd16d8437fd9c1a9ce9f7bd32123bfd';
  String description;
  SharedPreferences _preferences;
  int num2=0;
  int num=0;
  int num3=0;
  List<String> l1=['/clear sky.png','/clear-sky-night.png','/scattered clouds.png','/rain.png','/mist.png','/snow.png'];
  List<String> l2=['karaj','tehran','kashan','tabriz','zanjan','mashhad','kashmar','kashanak'];
  List<String> l3=[];
  List<Map> l4=[{'name':"New York"},{'name':"Washington"},{'name':"London"},{'name':"Paris"},{'name':"Berlin"},{'name':"Madrid"},{'name':"Beijing"},{'name':"Tokyo"},{'name':"New Delhi"},{'name':"Cairo"},];
  TextEditingController controller1=new TextEditingController();
  TextEditingController controller2=new TextEditingController();



  @override
  void initState() {

   futuremodel=fetchmodel();
   futuremodel2=fetchmodel2();
   icon_weather();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Weather"),),
      body:
          num==0 && num3==0 ?
                        Container(child: Column(children: [
                         SizedBox(width: 50,height: MediaQuery.of(context).size.height/20,),
                         Row(mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                            FutureBuilder<Model>(future: futuremodel,
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  var temp1=snapshot.data.temp-272.15;
                                  var city1=snapshot.data.city;
                                  var weather1=snapshot.data.weather;
                                  var tempmin1=snapshot.data.temp_min-272.15;
                                  var tempmax1=snapshot.data.temp_max-272.15;
                                  var timezone1=snapshot.data.timezone;
                                  description=weather1;
                                  return Container( height: 200,width: 400,child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(margin: EdgeInsets.only(top: 25,left: 25),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("$city1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                        Container(child: Image.asset(icon(timezone1)/*+weather1.toString()+".png"*/,height: 40,width: 40,),margin: EdgeInsets.only(left: 10),)
                                      ],
                                    ),
                                    IconButton(onPressed: (){alert1();controller1.clear();num2=0;}, icon: Icon(Icons.edit),padding: EdgeInsets.only(right: 30),)
                                  ],
                                )),
                                Container(margin: EdgeInsets.only(top: 5,left: 25),child: Text(convertTime(),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),))
                                ,Container(margin: EdgeInsets.only(top: 15),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text("temp : "+temp1.toStringAsFixed(0)+"°C"),Text("status : $weather1")],))
                                ,Container(margin: EdgeInsets.only(top: 10),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('temp min : '+tempmin1.toStringAsFixed(0)+"°C"),Text("temp max : "+tempmax1.toStringAsFixed(0)+"°C")],),),
                                ],),

                                  decoration: BoxDecoration(gradient: LinearGradient(colors:[Colors.red,Colors.blue]),
                                                 borderRadius: BorderRadius.all(Radius.circular(8))),);
                          }else{
                            return CircularProgressIndicator(color: Colors.blue,);
                          }

                        }
                        ,)
                     ,
                    ],
                  ),SizedBox(height: 15,),
                    Expanded(
                      child: FutureBuilder<Model_list>(future: futuremodel2,
                        builder: (context,snapshot){
                          if(snapshot.hasData){





                            return  GridView.count(crossAxisCount: 2,
                              children: List.generate(10, (index) {
                                return Container(margin: EdgeInsets.all(8),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange,Colors.red]),borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: Column(children: [Text("${snapshot.data.city[index]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                    Container(margin: EdgeInsets.only(top: 10),height: 5,color: Colors.black,),
                                    Container(margin: EdgeInsets.only(top: 20),child: Row(children: [Text("temp :  ${snapshot.data.temp[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                                    Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("status : ${snapshot.data.weather[index]}")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                                    Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("temp min : ${snapshot.data.temp_min[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                                    Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("temp max : ${snapshot.data.temp_max[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                                    Container(margin: EdgeInsets.only(top: 20),child: IconButton(icon: Icon(Icons.edit),onPressed: (){alert2(index);},),),
                                  ],),);
                              }),);




                            /* ListView.builder(itemBuilder: (context,index){
                                 return Container(margin: EdgeInsets.all(8),
                                   child: Center(child: Text(snapshot.data!.city[index])),color: Colors.orange,height: 50,);

                            },itemCount:10,);*/










                          }else if(snapshot.hasError){
                             print(snapshot.error.toString()+"///");
                             return Center(child: Container(child: Text("ERROR : ${snapshot.error.toString()}"),height: 50,),);

                          }else{
                            return Container(child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Center(child: CircularProgressIndicator(color : Colors.blue))],),width: MediaQuery.of(context).size.width,);
                          }


                        },


                )
              ),


      ],),):
                        Container( child: Column(children: [
                         SizedBox(width: 50,height: MediaQuery.of(context).size.height/20,),
                         Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                               FutureBuilder<Model>(future: futuremodel3,
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    var temp1=snapshot.data.temp-272.15;
                                    var city1=snapshot.data.city;
                                    var weather1=snapshot.data.weather;
                                    var tempmin1=snapshot.data.temp_min-272.15;
                                    var tempmax1=snapshot.data.temp_max-272.15;
                                    var timezone1=snapshot.data.timezone;
                                    description=weather1;
                                    return Container( height: 200,width: 400,child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                              Container(margin: EdgeInsets.only(top: 25,left: 25),child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("$city1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                                      Container(child: Image.asset(icon(timezone1)/*+weather1.toString()+".png"*/,height: 40,width: 40,),margin: EdgeInsets.only(left: 10),)
                                                    ],
                                                  ),
                                                  IconButton(onPressed: (){alert1();controller1.clear();num2=0;}, icon: Icon(Icons.edit),padding: EdgeInsets.only(right: 30),)
                                                ],
                                              )),
                                              Container(margin: EdgeInsets.only(top: 5,left: 25),child: Text(convertTime(),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),))
                                              ,Container(margin: EdgeInsets.only(top: 15),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text("temp : "+temp1.toStringAsFixed(0)+"°C"),Text("status : $weather1")],))
                                              ,Container(margin: EdgeInsets.only(top: 10),child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('temp min : '+tempmin1.toStringAsFixed(0)+"°C"),Text("temp max : "+tempmax1.toStringAsFixed(0)+"°C")],),),

                        ],),

                                decoration: BoxDecoration(gradient: LinearGradient(colors:[Colors.red,Colors.blue]),
                                      borderRadius: BorderRadius.all(Radius.circular(8))),);
                              }else{
                                    return SizedBox(child: CircularProgressIndicator(color: Colors.blue,),height: 50,width: 50,);
                              }

                  }
                  ,)
                ,
              ],
                       ),SizedBox(height: 15,),
                      Expanded(
                          child: FutureBuilder<Model_list>(future: futuremodel4,
                           builder: (context,snapshot){
                           if(snapshot.hasData){




                              return  GridView.count(crossAxisCount: 2,
                              children: List.generate(10, (index) {
                              return Container(margin: EdgeInsets.all(8),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange,Colors.red]),borderRadius: BorderRadius.all(Radius.circular(8))),
                              child: Column(children: [Text("${snapshot.data.city[index]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              Container(margin: EdgeInsets.only(top: 10),height: 5,color: Colors.black,),
                              Container(margin: EdgeInsets.only(top: 20),child: Row(children: [Text("temp :  ${snapshot.data.temp[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                              Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("status : ${snapshot.data.weather[index]}")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                              Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("temp min : ${snapshot.data.temp_min[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                              Container(margin: EdgeInsets.only(top: 10),child: Row(children: [Text("temp max : ${snapshot.data.temp_max[index].toStringAsFixed(0)}°C")],mainAxisAlignment: MainAxisAlignment.spaceAround,)),
                              Container(margin: EdgeInsets.only(top: 20),child: IconButton(icon:Icon(Icons.edit_outlined),onPressed: (){alert2(index);},),),
                            ],),);
                        }),);




                      /* ListView.builder(itemBuilder: (context,index){
                                 return Container(margin: EdgeInsets.all(8),
                                   child: Center(child: Text(snapshot.data!.city[index])),color: Colors.orange,height: 50,);

                            },itemCount:10,);*/










                               }else if(snapshot.hasError){
                                print(snapshot.error.toString()+"///");
                                return Center(child: Container(child: Text("ERROR : ${snapshot.error.toString()}"),height: 50,),);

                               }else{
                                return SizedBox(child: CircularProgressIndicator(color: Colors.blue,),height: 50,width: 50,);
                     }


                  },


                )
            ),


                            ],),)

                       );
                     }

  Future<Model> fetchmodel() async{
    _preferences=await SharedPreferences.getInstance();

    if(_preferences.getString('main_city')==null) {
      _preferences.setString("main_city", 'Karaj');
    }

    var url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${_preferences.getString("main_city")}&appid=$Api_Key');
    var response=await http.get(url);
    Map<String,dynamic> map=jsonDecode(response.body);


   // print(name);
    return Model.fromJson(map);
  }
  Future<Model_list> fetchmodel2() async{


      var f=await  Sqlite_DB().check_function();
      List<String> l_l=[];
      var i=0;
      while(i<f.length){
        l_l.add(f[i].city_name);
        i++;
      }



      var url0=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[0]}&appid=$Api_Key');
      var url1=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[1]}&appid=$Api_Key');
      var url2=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[2]}&appid=$Api_Key');
      var url3=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[3]}&appid=$Api_Key');
      var url4=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[4]}&appid=$Api_Key');
      var url5=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[5]}&appid=$Api_Key');
      var url6=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[6]}&appid=$Api_Key');
      var url7=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[7]}&appid=$Api_Key');
      var url8=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[8]}&appid=$Api_Key');
      var url9=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[9]}&appid=$Api_Key');
      var r0=await http.get(url0);
      var r1=await http.get(url1);
      var r2=await http.get(url2);
      var r3=await http.get(url3);
      var r4=await http.get(url4);
      var r5=await http.get(url5);
      var r6=await http.get(url6);
      var r7=await http.get(url7);
      var r8=await http.get(url8);
      var r9=await http.get(url9);
      Map<String,dynamic> map0=jsonDecode(r0.body);
      Map<String,dynamic> map1=jsonDecode(r1.body);
      Map<String,dynamic> map2=jsonDecode(r2.body);
      Map<String,dynamic> map3=jsonDecode(r3.body);
      Map<String,dynamic> map4=jsonDecode(r4.body);
      Map<String,dynamic> map5=jsonDecode(r5.body);
      Map<String,dynamic> map6=jsonDecode(r6.body);
      Map<String,dynamic> map7=jsonDecode(r7.body);
      Map<String,dynamic> map8=jsonDecode(r8.body);
      Map<String,dynamic> map9=jsonDecode(r9.body);
      List list=[map0,map1,map2,map3,map4,map5,map6,map7,map8,map9];
      return Model_list.fromJson(list);



  }

   Future<Model> fetchmodel3() async{
     _preferences=await SharedPreferences.getInstance();
     if(_preferences.getString('main_city')==null) {
       _preferences.setString("main_city", 'Karaj');
     }

     var url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${_preferences.getString("main_city")}&appid=$Api_Key');
     var response=await http.get(url);
     Map<String,dynamic> map=jsonDecode(response.body);


     // print(name);
     return Model.fromJson(map);
   }
   Future<Model_list> fetchmodel4() async{


     var f=await  Sqlite_DB().check_function();
     List<String> l_l=[];
     var i=0;
     while(i<f.length){
       l_l.add(f[i].city_name);
       i++;
     }



     var url0=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[0]}&appid=$Api_Key');
     var url1=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[1]}&appid=$Api_Key');
     var url2=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[2]}&appid=$Api_Key');
     var url3=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[3]}&appid=$Api_Key');
     var url4=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[4]}&appid=$Api_Key');
     var url5=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[5]}&appid=$Api_Key');
     var url6=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[6]}&appid=$Api_Key');
     var url7=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[7]}&appid=$Api_Key');
     var url8=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[8]}&appid=$Api_Key');
     var url9=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${l_l[9]}&appid=$Api_Key');
     var r0=await http.get(url0);
     var r1=await http.get(url1);
     var r2=await http.get(url2);
     var r3=await http.get(url3);
     var r4=await http.get(url4);
     var r5=await http.get(url5);
     var r6=await http.get(url6);
     var r7=await http.get(url7);
     var r8=await http.get(url8);
     var r9=await http.get(url9);
     Map<String,dynamic> map0=jsonDecode(r0.body);
     Map<String,dynamic> map1=jsonDecode(r1.body);
     Map<String,dynamic> map2=jsonDecode(r2.body);
     Map<String,dynamic> map3=jsonDecode(r3.body);
     Map<String,dynamic> map4=jsonDecode(r4.body);
     Map<String,dynamic> map5=jsonDecode(r5.body);
     Map<String,dynamic> map6=jsonDecode(r6.body);
     Map<String,dynamic> map7=jsonDecode(r7.body);
     Map<String,dynamic> map8=jsonDecode(r8.body);
     Map<String,dynamic> map9=jsonDecode(r9.body);
     List list=[map0,map1,map2,map3,map4,map5,map6,map7,map8,map9];
     return Model_list.fromJson(list);



   }

  convertTime(){
    var now=DateTime.now();
    var year=now.year.toString();
    var month=now.month.toString();
    var day=now.day.toString();

    return "$year/$month/$day";

  }
  icon_weather() async{
   var date= DateTime.utc(2016,2,10,5,30,16);
   print(date);


    }
  alert1(){


    return showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(builder: (context,setState){
        return  AlertDialog(title: Row(
          children: [
            Text("Enter City Name :",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(width: 140,),
            IconButton(onPressed: (){Navigator.pop(context);controller1.clear();}, icon: Icon(Icons.close))
          ],
        ),
          actions: [

            Center(child: MaterialButton(onPressed: (){update_main_feild();Navigator.pop(context);},child: Text("Click"),color: Colors.blue,)),

          ],content:SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(decoration: InputDecoration(hintText: "City Name:",),autofocus: true,controller: controller1,
                          onChanged: (text){/*text_controller();*/},),
               D==true ? Container(width: 100,child: ListView.builder(itemBuilder: (context,index){
                          return InkWell(child: Container(child: Center(child: Text(l3[index],style: TextStyle(color: Colors.black),)),color: Colors.white,height: 20,),onTap: (){click_con_alert(l3[index]);},);
                },itemCount: l3.length,shrinkWrap: true,),height:75,color: Colors.white,)
                   : Container(height: 1,)


              ],
            ),
          )
          ,


        );}
      );

    }
    );}
  alert2(int index){


     return showDialog(context: context, builder: (BuildContext context){
       return StatefulBuilder(builder: (context,setState){
         return  AlertDialog(title: Row(
           children: [
             Text("Enter City Name :",style: TextStyle(fontWeight: FontWeight.bold),),
             SizedBox(width: 140,),
             IconButton(onPressed: (){Navigator.pop(context);controller2.clear();}, icon: Icon(Icons.close))
           ],
         ),
           actions: [

             Center(child: MaterialButton(onPressed: (){update_list_city(controller2.text,index);Navigator.pop(context);controller2.clear();},child: Text("Click"),color: Colors.blue,)),

           ],content:SingleChildScrollView(
             child: ListBody(
               children: [
                 TextField(decoration: InputDecoration(hintText: "City Name:",),autofocus: true,controller: controller2,
                   onChanged: (text){/*text_controller2(index);*/},),
               F==true ?  Container(width: 100,child: ListView.builder(itemBuilder: (context,index){
                          return Container(child: Text(l3[index],style: TextStyle(color: Colors.black),),color: Colors.white,height: 20,);
                          },itemCount: l3.length,shrinkWrap: true,),height:75,color: Colors.white,)
                   :Container(height: 1,)


               ],
             ),
           )
           ,


         );}
       );

     }
     );}

    text_controller(){
       l3=[];
       if(controller1.text.length>2&&num2==0){

               D=true;
              // num2+=1;

//'karaj','tehran','kashan','tabriz','zanjan','mashhad','kashmar'
               var i=0;
               while(i<l2.length){
                 if(l2[i].contains(controller1.text.toString())){

                       if(l3.isEmpty){
                         l3.add(l2[i]);
                       }else{
                         var ii=0;
                         while(ii<l3.length){
                           if(l3[ii].contains(l2[i])){
                             break;
                           }else{
                             if(ii==l3.length-1){
                               l3.add(l2[i]);
                             }
                           }
                           ii++;
                         }
                       }
                 }
                 i++;
               }

               Navigator.pop(context);
               alert1();



       }else if(num2==1&&controller1.text.length>2){
         D=true;
         var i=0;
         while(i<l2.length){
           if(l2[i].contains(controller1.text.toString())){

             if(l3.isEmpty){
               l3.add(l2[i]);
             }else{
               var ii=0;
               while(ii<l3.length){
                 if(l3[ii].contains(l2[i])==false){
                   l3.add(l2[i]);

                 }
                 ii++;
               }
             }
           }
           i++;
         }

         Navigator.pop(context);
         alert1();



       }else if(controller1.text.length<=2){
         D=false;
         Navigator.pop(context);
         alert1();
       }


    }
    text_controller2(int index){
       l3=[];
       if(controller1.text.length>2&&num2==0){
       F=true;
       // num2+=1;

//'karaj','tehran','kashan','tabriz','zanjan','mashhad','kashmar'
       var i=0;
       while(i<l2.length){
         if(l2[i].contains(controller1.text.toString())){

           if(l3.isEmpty){
             l3.add(l2[i]);
           }else{
             var ii=0;
             while(ii<l3.length){
               if(l3[ii].contains(l2[i])){
                 break;
               }else{
                 if(ii==l3.length-1){
                   l3.add(l2[i]);
                 }
               }
               ii++;
             }
           }
         }
         i++;
       }

       Navigator.pop(context);
       alert2(index);



     }else if(num2==1&&controller1.text.length>2){
       F=true;
       var i=0;
       while(i<l2.length){
         if(l2[i].contains(controller1.text.toString())){

           if(l3.isEmpty){
             l3.add(l2[i]);
           }else{
             var ii=0;
             while(ii<l3.length){
               if(l3[ii].contains(l2[i])==false){
                 l3.add(l2[i]);

               }
               ii++;
             }
           }
         }
         i++;
       }

       Navigator.pop(context);
       alert2(index);



     }else if(controller1.text.length<=2){
       F=false;
       Navigator.pop(context);
       alert2(index);
     }


   }
    k1(){
       print('//////START//////');
       var p=0;
       while(p<l3.length){
         print(l3[p]);
         p++;
       }
       print('//////END///////');
    }
    update_main_feild() async{

      _preferences=await SharedPreferences.getInstance();
      _preferences.setString('main_city', controller1.text.toString());
      if(num==0){
        num=1;
        setState(() {
          futuremodel3=fetchmodel3();
        });
      }else{
          num=0;
          setState(() {
            futuremodel=fetchmodel();
          });
      }
    }
    update_list_city(String cityname,int index) async{

       await Sqlite_DB().updateData(DB_Model(city_name: cityname,id: index+1));
       if(num3==0){
         num3=1;
         setState(() {
           futuremodel4=fetchmodel4();
         });
       }else{
         num3=0;
         setState(() {
           futuremodel2=fetchmodel2();
         });
       }


    }
    click_con_alert(String s){
    controller1.text=s;

    }
      icon(int timezone){
       var t=  DateTime.now().add(Duration(seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));
       print(description);
       switch(description){
         case "haze":
           return 'assets/haze.png';
           break;
         case 'snow':
           return 'assets/snow.png';
           break;
         case 'thunderstorm' :
           return 'assets/thunderstorm.png';
           break;
         case 'broken clouds':
           return 'assets/scattered clouds.png';
           break;
         case 'scattered clouds':
           return 'assets/scattered clouds.png';
           break;
         case 'few clouds':
           if(t.hour>7&&t.hour<18){
             return 'assets/sunny.png';
           }else{
             return 'assets/night.png';
           } break;
         case 'shower rain':
           return 'assets/raining.png.png';
           break;
         case 'rain':
           if(t.hour>7&&t.hour<18){
             return 'assets/rain.png';
           }else{
             return 'assets/slight-rain.png';
           } break;
         case 'clear sky':
           if(t.hour>7&&t.hour<18){
             return 'assets/clear sky.png';
           }else{
             return 'assets/clear-sky-night.png';
           } break;
         case 'overcast clouds':
           return 'assets/scattered clouds.png';
           break;
         case 'smoke':
           return 'assets/mist.png';
           break;
         case 'fog':
           return 'assets/haze.png';
           break;
         case 'mist':
           return 'assets/haze.png';
           break;

       }




      }



}
