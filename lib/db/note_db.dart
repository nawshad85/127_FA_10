
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase{
  final database = Supabase.instance.client.from("notes");

  //insert or create er kaj
  Future<void> createNote(String note)async{
    await database.insert({'content' : note});
  }

  // update er kaj
  Future<void> updateNote(dynamic noteId, String updatedNote)async{
    await database.update({'content': updatedNote}).eq('id', noteId);
  }

  // delete er kaj
  Future<void> deleteNote(dynamic noteId)async{
    await database.delete().eq('id', noteId);
  }
}