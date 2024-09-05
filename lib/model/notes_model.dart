
import 'package:todo_with_cubit/database/local/db_helper.dart';

class NotesModel{
  int? sno;
  String title;
  String desc;
  int completed;
  NotesModel({this.sno,required this.title,required this.desc,this.completed=0 });

  factory NotesModel.from(Map<String,dynamic>map){
    return NotesModel(sno:map[DbHelper.COLUMN_S_NO],title:map[DbHelper.COLUMN_TITLE], desc: map[DbHelper.COLUMN_DESC],completed: map[DbHelper.COMPLETED]);
  }
  Map<String,dynamic>toMap(){
    return{
      DbHelper.COLUMN_TITLE:title,
      DbHelper.COLUMN_DESC:desc,
      DbHelper.COMPLETED:completed,
    };
  }
}