import 'package:flutter/material.dart';
import 'package:loginpage/db/note_db.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});
  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final noteController = TextEditingController();
  final notesdb = NoteDatabase();
  void addNewNote(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("New Note"),
          content: TextField(
            controller: noteController,
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              noteController.clear();
            }, child: Text("Cancel")),
            TextButton(onPressed: ()async{
              try{
                await notesdb.createNote(noteController.text);
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note Added")));
                  Navigator.pop(context);
                  noteController.clear();
                }
              }
              catch(e){
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              }
            }, child: Text("Save")),
          ],
        )
    );
  }

  void updateNote(dynamic id, String oldNote){
    noteController.text = oldNote ?? "";
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Update Note"),
          content: TextField(
            controller: noteController,
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              noteController.clear();
            }, child: Text("Cancel")),
            TextButton(onPressed: ()async{
              try{
                final updatedNote = noteController.text;
                await notesdb.updateNote(id, updatedNote);
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note Updated")));
                  Navigator.pop(context);
                  noteController.clear();
                }
              }
              catch(e){
                if(mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              }
            }, child: Text("Update")),
          ],
        )
    );
  }

  void deleteNote(dynamic id) async{
    try{
      await notesdb.deleteNote(id);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note Deleted")));
      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addNewNote,
          child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: notesdb.database.stream(primaryKey: ['id']),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            final notes = snapshot.data!;
            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index){
                  final note = notes[index];
                  final id = note['id'];
                  final content = note['content'];
                  return Card(
                    child: ListTile(
                      title: Text(content),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            deleteNote(id);
                          }, icon: Icon(Icons.delete)),
                          IconButton(onPressed: (){
                            updateNote(id, content);
                          }, icon: Icon(Icons.edit)),
                        ],
                      ),
                    )
                  );
                }
            );
          }
      ),
    );
  }
}
