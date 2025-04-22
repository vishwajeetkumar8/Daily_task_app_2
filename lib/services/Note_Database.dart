import 'package:daily_task_app/services/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class noteDatabase{
  final database =Supabase.instance.client.from('Daily task');

  //Create
Future createNote(Note newNote) async {
  await database.insert(newNote.toMap());
}

 //Read
 final stream = Supabase.instance.client.from('Daily task').stream(
   primaryKey: ['id'],
 ).map((data)=>data.map((noteMap)=>Note.fromMap(noteMap)).toList());

//Delete
Future deleteNote(Note note)async{
  await database.delete().eq('id', note.id!);
}


}