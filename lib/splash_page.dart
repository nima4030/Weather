import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';

void main()=>runApp(SplashApp());
 class SplashApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,),
      home: Splash_Activity(),
      debugShowCheckedModeBanner: false,
    );
  }

}
class Splash_Activity extends StatefulWidget {


  @override
  _Splash_ActivityState createState() => _Splash_ActivityState();
}

class _Splash_ActivityState extends State<Splash_Activity> {
  @override
  void initState() {
    delayed();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueAccent,child: Center(child: Lottie.asset("assets/animation.json"),),);
  }



  delayed(){
    new Future.delayed(const Duration(seconds: 5),(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Page_1()));
    });
  }
}

