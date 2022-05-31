import 'package:flutter/material.dart';
import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled3con/screens/teamDetails.dart';

import 'dart:io';
class CreateTeam extends StatefulWidget {
  var userId;
  CreateTeam({required this.userId});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  var conTitle=TextEditingController();
  var conDescription=TextEditingController();
  var conCreated_Date=TextEditingController();
  var created_Date;
  var member;
  List members=[];
  bool wait=false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Team Page"),
        actions: [
          ElevatedButton(onPressed: ()async{
            setState(() {
              wait=true;
            });
            print(conTitle.text);
            provider.getUsers();
            provider.getTeams();
            provider.getProfiles();
            int id=provider.teams[provider.teams.indexWhere((element) => element.title==conTitle.text)].id;
            print(id);
            members.forEach((element) async{
              await  provider.addMember(id, element).then((value){setState(() {
                wait=false;
              });});
            });


          }, child: Text("add all members"))
        ],
      ),
      body:
      SingleChildScrollView(
        child: Column(

          children: [
            wait==true?CircularProgressIndicator():
            Container(
              padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.red)
              ),
              child: TextField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Title",
                ),
                controller: conTitle,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10,2,10,2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.red)
              ),
              child: TextField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Description",
                ),
                controller: conDescription,
              ),
            ),
            SizedBox(height: 10,),
            Text("Choose a members",style: TextStyle(fontWeight: FontWeight.bold),),
            DropdownButton(items:
            [
             ...provider.users.map((e){
               return  DropdownMenuItem(value:e.username,child: Text(e.username),);
             }).toList(),
            ],
              value: member,
              onChanged: (value){
                setState(() {
                  member=value;
                  if(members.contains(value)==false) {
                    members.add(value);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$member has been added")));
                  }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$member has been removed")));
                    members.remove(member);
                  }

                });
              },
            ),

            SizedBox(height: 30,),
            ElevatedButton(
                onPressed:()async{
setState(() {
  wait=true;
});
                  var leaderName=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].username;
                  print(leaderName);
                  provider.createTeam(
                      conTitle.text.toString(),
                      conDescription.text.toString(),
                      leaderName.toString(),
                     "2022-05-16",
                  ).then((value){
                    setState(() {
                      wait=false;
                    });
                  });
                } ,
                child: Text("Create Team"))
          ],
        ),
      ),
    );
  }
}
