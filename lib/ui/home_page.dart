
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/cubit/cubit_notes.dart';
import 'package:todo_with_cubit/model/notes_model.dart';
import 'package:todo_with_cubit/notes_state.dart';
import 'package:todo_with_cubit/ui/detail_page.dart';

class HomePage extends StatelessWidget{
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<CubitNotes>().getAllData();
    return Scaffold(
      appBar: AppBar(
        title:Text("DoTo App with Cubit"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CubitNotes,NotesState>(builder:(_,state){
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator(),);
                }else if(state is ErrorState){
                  return Center(child: Text("error ${state.error}"),);
                }else if(state is LoadedState){
                  List<NotesModel>mNotes=state.mData;
                  return SizedBox(
                    height: 650,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: mNotes.length,
                        itemBuilder: (_,index){
                          return Stack(
                            children: [
                              Container(
                                height:120,
                                margin: EdgeInsets.all(11),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(sno: mNotes[index].sno!, title: mNotes[index].title, desc:mNotes[index].desc,),));
                                  },
                                  child: Card(
                                      //margin: EdgeInsets.all(20),
                                      elevation: 6,
                                      child: Column(
                                        children: [
                                          CheckboxListTile(
                                              controlAffinity: ListTileControlAffinity.leading,
                                              title:Row(
                                                children: [
                                                  SizedBox(width: 170,
                                                    child: Text(mNotes[index].title),),
                                                  SizedBox(width: 10,),
                                                  IconButton(onPressed: (){
                                                    context.read<CubitNotes>().delete(sno: mNotes[index].sno!);
                                                  }, icon: Icon(Icons.delete)),
                                                ],
                                              ),
                                              value: mNotes[index].completed==1, onChanged:(value){
                                            var update=NotesModel(title: mNotes[index].title, desc:mNotes[index].desc,sno: mNotes[index].sno,completed: value! ? 1 :0);
                                            context.read<CubitNotes>().update(update, sno:mNotes[index].sno!);
                                          }),
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  );
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          titleController.clear();
          descController.clear();
          showModalBottomSheet(context: context, builder:(_){
            return Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller:titleController ,
                    ),
                    TextField(
                      controller: descController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: (){
                          context.read<CubitNotes>().add(NotesModel(title: titleController.text, desc: descController.text));
                          Navigator.pop(context);
                        }, child: Text("add")),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Cancle")),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        },child: Icon(Icons.add),
      ),
    );
  }
}