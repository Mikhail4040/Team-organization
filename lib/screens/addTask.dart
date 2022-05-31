import 'package:flutter/material.dart';

import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  var leaderId;
  var teamId;

  AddTask({required this.leaderId, required this.teamId});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var conTitle = TextEditingController();
  var conDescription = TextEditingController();
  var conDeadLine = TextEditingController();

  var member;
  List members = [];

  bool wait=false;

  TextField createTextFielf(var con, var text) {
    return TextField(
      decoration: InputDecoration(
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.green, width: 3),
        ),
      ),
      controller: con,
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
   List membersInThisGroup= provider.teams[provider.teams.indexWhere((element) => element.id==widget.teamId)].members;
   // print("i ist:");
   // print(i.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task Page"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                createTextFielf(conTitle, "Tilte"),
                SizedBox(
                  height: 15,
                ),
                createTextFielf(conDescription, "Description"),
                SizedBox(
                  height: 15,
                ),
                createTextFielf(conDeadLine, "DeadLine"),
                SizedBox(
                  height: 15,
                ),



                Text(
                  "Choose a members",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                  items: [
                    ...membersInThisGroup.map((e) {
                      var userName=provider.users[provider.users.indexWhere((element) => element.id==e)].username;
                      return DropdownMenuItem(
                        value: userName,
                        child: Text(userName),
                      );
                    }).toList(),
                  ],
                  value: member,
                  onChanged: (value) {
                    setState(() {
                      member = value;
                      if (members.contains(value) == false) {
                        if (members.length <= 0) {
                          members.add(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("$member has been added")));
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "You can direct the task to one person only")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$member has been removed")));
                        members.remove(member);
                      }
                    });
                  },
                ),

                ElevatedButton(
                    onPressed:()async{
                      setState(() {
                        wait=true;
                      });
                      var leaderName = provider.users[provider.users.indexWhere((
                          element) => element.id == widget.leaderId)].username;
                      print(leaderName);
                      var forU=await provider.users[provider.users.indexWhere((element) => element.username==member)].username;
                      print(forU);
                      await provider.addTask(
                          conTitle.text,
                          conDescription.text,
                          "2022-05-16",
                          conDeadLine.text,
                          "False",
                          conDeadLine.text,
                          leaderName,
                          member,
                          widget.teamId,
                      ).then((value){setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("The Task has been added")));
                        members.remove(member);
                        wait=false;
                      });});
                    },
                    child: Text("Add a Task")
                ),
                wait==true?CircularProgressIndicator():Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

