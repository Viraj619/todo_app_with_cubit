
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/cubit_notes.dart';
import 'package:todo_with_cubit/model/notes_model.dart';
import 'package:todo_with_cubit/ui/home_page.dart';

class DetailPage extends StatelessWidget{
  int sno;
  String title,desc;

  DetailPage({required this.sno, required this.title,required this.desc,});
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text=title;
    descController.text=desc;
    return Scaffold(
      appBar:  AppBar(
        title: Text("Details"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller:titleController,
              ),
              TextField(
                controller: descController,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                ElevatedButton(onPressed: (){
                  context.read<CubitNotes>().update(NotesModel(title: titleController.text, desc:descController.text), sno: sno);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(),));
                }, child: Text("Save")),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancle")),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}