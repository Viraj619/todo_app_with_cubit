
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/database/local/db_helper.dart';
import 'package:todo_with_cubit/model/notes_model.dart';
import 'package:todo_with_cubit/notes_state.dart';

class CubitNotes extends Cubit<NotesState>{
  DbHelper dbHelper;
  CubitNotes({required this.dbHelper}):super(InitState());

  /// add events
 void add(NotesModel add)async{
   bool check=await dbHelper.addNotes(newNotes: add);
   emit(LoadingState());
   if(check){
     var notes=await dbHelper.fetchAllNotes();
     emit(LoadedState(mData: notes));
   }else{
     emit(ErrorState(error: "Note not added!!!"));
   }
 }
 /// update events
void update(NotesModel updated,{required int sno})async{
   emit(LoadingState());
   bool check = await dbHelper.updateNotes(updatedNotes: updated, sno: sno);
   emit(LoadingState());
   if(check){
     var notes= await dbHelper.fetchAllNotes();
     emit(LoadedState(mData: notes));
   }else{
     emit(ErrorState(error: "Note not updated !!!"));
   }
}
 /// delete events
void delete({required int sno})async{
   bool check = await dbHelper.delete(sno: sno);
   if(check){
     var notes= await dbHelper.fetchAllNotes();
     emit(LoadedState(mData: notes));
   }else{
     emit(ErrorState(error: "Note not Deleted !!!"));
   }
}
/// initstate event
void getAllData()async{
   emit(LoadingState());
   var notes= await dbHelper.fetchAllNotes();
   emit(LoadedState(mData: notes));
}
}