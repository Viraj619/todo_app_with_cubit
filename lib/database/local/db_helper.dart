
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_with_cubit/model/notes_model.dart';

class DbHelper{

  DbHelper._();
  static DbHelper getInstance()=>DbHelper._();

  static String TABLE_TODO="todo";
  static String COLUMN_S_NO="s_no";
  static String COLUMN_TITLE="title";
  static String COLUMN_DESC="desc";
  static String COMPLETED="completed";

  Database? mDb;

  Future<Database>getDB()async{
    mDb??=await openDB();
    return mDb!;
  }
  Future<Database>openDB()async{
    Directory appDir= await getApplicationDocumentsDirectory();
    String dbPath=join(appDir.path," todo DB.db");

    return await openDatabase(dbPath,onCreate: (db,version){
      db.execute(" create table $TABLE_TODO ( $COLUMN_S_NO integer primary key autoincrement , $COLUMN_TITLE text, $COLUMN_DESC text, $COMPLETED integer)");
    },version: 1);
  }

  Future<bool> addNotes({required NotesModel newNotes})async{
    var mDb= await getDB();
    int rowEffected= await mDb.insert(TABLE_TODO,newNotes.toMap());
    return rowEffected>0;
  }
  Future<bool>updateNotes({required NotesModel updatedNotes,required int sno})async{
    var mDb=await getDB();
    int rowEffected=await mDb.update(TABLE_TODO,updatedNotes.toMap(),where:"$COLUMN_S_NO=?",whereArgs: [sno]);
    return rowEffected>0;
  }
  Future<bool>delete({required int sno})async{
    var mDb=await getDB();
    int rowEffected=await mDb.delete(TABLE_TODO,where:"$COLUMN_S_NO=?",whereArgs: [sno]);
    return rowEffected>0;
  }
  Future<List<NotesModel>> fetchAllNotes()async{
    var mDb=await getDB();
    var data=await mDb.query(TABLE_TODO);
    List<NotesModel>mNotes=[];
    for(Map<String,dynamic> eachData in data){
      mNotes.add(NotesModel.from(eachData));
    }
    return mNotes;
  }
}