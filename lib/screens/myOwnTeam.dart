import 'package:flutter/material.dart';
import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled3con/backend/team.dart';
import 'package:untitled3con/screens/teamDetails.dart';

class MyOwnTeam extends StatefulWidget {
  var userId;
  MyOwnTeam({required this.userId});

  @override
  State<MyOwnTeam> createState() => _MyOwnTeamState();
}

class _MyOwnTeamState extends State<MyOwnTeam> {
  bool wait=false;
  String userName="";
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Own Teams Page"),
        actions: [
          IconButton(
            onPressed: ()async{
              print(widget.userId);
              setState(() {
                wait=true;
              });
              provider.teams.clear();
             await provider.getUsers();
             await provider.getTeams().then((value){setState(() {
               wait=false;
             });
              userName=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].username;
             });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body:
      wait==true?CircularProgressIndicator():
          userName!=""?
          Column(
            children: [
              ...provider.teams.where((element) => element.leader==widget.userId).map((e){
                var leaderTeamName=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].username;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    //  height: 100,
                    child: Card(
                      color: Colors.indigo,
                      elevation: 5,
                      child: Column(
                        children: [
                          Text(e.title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                          Divider(thickness: 2,height: 3,),
                          Text(e.description,style: TextStyle(color: Colors.white,fontSize: 20)),
                          Divider(thickness: 2,height: 3,),
                          Text("Leader Name is: $leaderTeamName",style: TextStyle(color: Colors.white,fontSize: 20)),
                          Divider(thickness: 2,height: 3,),
                          Text(e.created_Date,style: TextStyle(color: Colors.white,fontSize: 20)),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_){
                                      return TeamDetails(teamId: e.id,isLeader: true,userId: widget.userId,);
                                    })
                                );
                              },
                              child:Text("Inter")
                          ),
                          TextButton(
                            onPressed: ()async{
                                await provider.deleteTeam(e.id);
                            },
                            child: Text("Delete This Team",style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ):
              Text("There is no team that you lead",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),),
    );
  }
}
