
import 'package:todo_with_cubit/model/notes_model.dart';

 abstract class NotesState{
  // late List<NotesModel>mData;
  // NotesState({required this.mData});
}
class InitState extends NotesState{

}
class LoadingState extends NotesState{

}
class LoadedState extends NotesState{
  late List<NotesModel>mData;
  LoadedState({required this.mData});
}
class ErrorState extends NotesState{
   String error;
   ErrorState({required this.error});
}