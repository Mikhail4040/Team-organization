import 'package:flutter/material.dart';

import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';

class TeamDetails extends StatefulWidget {
  var teamId;
  bool isLeader;
  var userId;
  TeamDetails({required this.teamId,required this.isLeader,required this.userId});

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  bool wait1=false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    provider.getUsers();
   // provider.getTeams();
    var title=provider.teams[provider.teams.indexWhere((element) => element.id==widget.teamId)].title;
    var description=provider.teams[provider.teams.indexWhere((element) => element.id==widget.teamId)].description;
    var leader=provider.teams[provider.teams.indexWhere((element) => element.id==widget.teamId)].leader;
    List membersId=provider.teams[provider.teams.indexWhere((element) => element.id==widget.teamId)].members;

    List membersName=[];
    membersId.forEach((e) {
    membersName.add(provider.users[provider.users.indexWhere((element) => element.id==e)].username);
    });





    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed:()async{
                provider.tasks.clear();
               await provider.getTasks();
             //  print(provider.tasks.length);
              } ,
              icon: Icon(Icons.refresh))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:(){
          widget.isLeader==true?
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return AddTask(leaderId: leader,teamId: widget.teamId,);
          })):
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You cannot add from here")  ));

        } ,
        child: Icon(Icons.add),
      ),

      
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...provider.tasks.where((element) => element.team==widget.teamId).map((e) {
              var forUser=provider.users[provider.users.indexWhere((ee) => ee.id==e.forUser)].username;
              var userName=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].username;
             // print(userName);
             // print(forUser);
              bool isDone=e.is_Done;
          //    print(isDone);
              return Container(
                padding: EdgeInsets.all(30),
                width:700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                  child: Column(
                    children: [
                      Container(
                        child:Row(
                          children: [
                            Text("Created in:"),
                            Text(e.created_Date),

                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                        ),
                        child: Text(e.title),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        child:Text(e.description),
                        padding: const EdgeInsets.all(12),
                      ),
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Estimated number of important days:"),
                            Text(e.deadLine.toString())
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                      ),

                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("The task is directed only to:",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(forUser),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                      widget.isLeader==true?
                      ElevatedButton(
                          onPressed:()async{
                            await provider.deleteTask(e.id);
                          },
                          child:Text("Delete",style: TextStyle(color: Colors.red),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black)
                        ),
                      ):
                          Container(),
                      
                     //  userName==forUser?
                     //     Column(
                     //       children: [
                     //         SizedBox(height: 10,),
                     //         Text("Is the Task over?",),
                     //         ElevatedButton(
                     //           child: Text("The Task has been Done"),
                     //           onPressed: ()async{
                     //             setState(() {
                     //               wait1=true;
                     //             });
                     //             var id=e.id;
                     //             var title=e.title;
                     //             var descreption=e.description;
                     //             var leaderName = provider.users[provider.users.indexWhere((
                     //                 element) => element.id == e.author)].username;
                     //
                     //             var forU=provider.users[provider.users.indexWhere((element) => element.id==e.forUser)].username;
                     //
                     //             await provider.updateTask(
                     //               e.id,
                     //               e.title,
                     //               e.description,
                     //               e.created_Date,
                     //               e.deadLine,
                     //               "False",
                     //               e.dyas_Left,
                     //               leaderName,
                     //                forU,
                     //                e.team,
                     //             ).then((value){
                     //               setState(() {
                     //                 wait1=false;
                     //               });
                     //
                     //             });
                     //           },
                     //         ),
                     //       ],
                     //     ):
                     //      Container(),
                     //
                     // wait1==true?CircularProgressIndicator():Container(),
                    ],
                  ),

              );
            }).toList(),
          ],
        ),
      ),

    );
  }
}
