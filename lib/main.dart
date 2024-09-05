import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/cubit_notes.dart';
import 'package:todo_with_cubit/database/local/db_helper.dart';
import 'package:todo_with_cubit/ui/home_page.dart';

void main(){
  runApp(BlocProvider(create: (context) =>CubitNotes(dbHelper: DbHelper.getInstance()),
  child:MainApp(),));
}
class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}