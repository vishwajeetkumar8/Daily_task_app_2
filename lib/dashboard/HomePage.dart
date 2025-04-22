import 'package:daily_task_app/services/note.dart';
import 'package:flutter/material.dart';
import '../app/theme.dart';
import '../auth/auth_service.dart';
import '../services/Note_Database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  ///Database
  final authServic = AuthService();

   ///Logout
  void logout()async{
    await authServic.signOut();
  }

  //text controller
  final noteController = TextEditingController();

  /// user want to add new note
   void addNewNote(){
     showDialog(context: context, builder: (context)=>AlertDialog(
       title: const Text("New Note"),
       content: TextField(
         controller: noteController,
       ),
       actions: [
         ///Cancel Button
         TextButton(onPressed: (){
           Navigator.pop(context);
           noteController.clear();
         }, child: Text('Cancel')),
         /// Save Button
         TextButton(onPressed: (){
           setState(() {
           final newNote = Note(content: noteController.text);
             noteDatabase().createNote(newNote);
           Navigator.pop(context);
           noteController.clear();
           });
         }, child: Text('Save')),
       ],
     )
     );
   }

  ///user want to delete
void deleteNote(Note note){
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: const Text("Delete Note"),
    actions: [
      ///Cancel Button
      TextButton(onPressed: (){
        Navigator.pop(context);
        noteController.clear();
      }, child: Text('Cancel')),
      /// Save Button
      TextButton(onPressed: (){
        setState(() {
          noteDatabase().deleteNote(note);
          Navigator.pop(context);
          noteController.clear();
        });
      }, child: Text('Delete')),
    ],
  )
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's task",style: TextStyle(fontWeight: FontWeight.bold,color: appColor().TextPrimary),),
        centerTitle: true,
        backgroundColor: appColor().Background,
        actions: [
          IconButton(onPressed: (){logout();}, icon: Icon(Icons.logout,color: appColor().TextPrimary,))
        ],
        leading: IconButton(onPressed: () {
         setState(() {
           appColor().changeMode();
         });
        }, icon:appColor().iconChange),
        
      ),
      backgroundColor: appColor().Background,
      floatingActionButton: FloatingActionButton(onPressed: (){
        addNewNote();
      },child: Icon(Icons.add),),
      body:StreamBuilder(
          stream: noteDatabase().stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            final notes= snapshot.data!;

            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context,index){
                  final note = notes[index];
                  return  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 20,top: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: appColor().Primary,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           Text(note.content,style: TextStyle(color: Colors.white,fontSize: 20),),
                          IconButton(onPressed:(){deleteNote(note);} , icon: Icon(Icons.delete,color: Colors.white,)),

                        ],
                      ),
                    ),
                  );
            }
            );
          },) ,
    );
  }
}
