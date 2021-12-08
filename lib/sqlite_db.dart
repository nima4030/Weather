import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Sqlite_DB {
  Database _db2;
  SharedPreferences _pref;

  Future openDB() async{
    _db2=await openDatabase(join(await getDatabasesPath(),"db.2"),
        version: 1, onCreate:(Database db,int version) async {
          await db.execute(
            "CREATE TABLE city_map(id INTEGER PRIMARY KEY autoincrement, city_name TEXT)",
          );
        });

    return _db2;
  }

  insertDB(DB_Model model) async{

    await openDB();
    return await _db2.insert("city_map",model.tojson());
  }
  Future<List<DB_Model>> getDataList() async{
    await openDB();
    final List<Map<String,dynamic>> maps=await _db2.query("city_map");
    return List.generate(maps.length, (i){

      return DB_Model(
          city_name: maps[i]['city_name'],
          );
    });


  }
  Future<List<DB_Model>> getData() async{

    await openDB();
    final List<Map<String,dynamic>> m=await _db2.query("city_map");
    return  List.generate(m.length, (index){
      return DB_Model(
          city_name: m[index]['city_name'],
          id:m[index]['id']
          );
    });
  }
  deleteData(DB_Model model2) async{
    await openDB();
    _db2.delete('city_map',where: "id = ?",whereArgs: [model2.id]);

  }
  updateData(DB_Model db_model) async{
    await openDB();
    //return _db2.rawQuery('UPDATE city_map SET city_name = "Tehran" where id = 0 ');
    return _db2.update('city_map', db_model.tojson(),where: "id = ?",whereArgs: [db_model.id]);

  }

 Future<List<DB_Model>> check_function() async{

    List<String> list4;
    var i=0;
    _pref=await SharedPreferences.getInstance();
    if(_pref.getInt('check_int')==null){
      print("////problem////");
      _pref.setInt('check_int', 1);
      _pref.setStringList('default_list',  list4=["New York","Washington","London","Paris","Berlin","Madrid","Beijing","Tokyo","New Delhi","Cairo"]);
      while(i<list4.length){
        await insertDB(DB_Model(city_name: list4[i]));
        i++;
      }
      return await getData();

    }else{
        return await getData();


      }

  }

}