import 'package:flutter/material.dart';
import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled3con/screens/teamDetails.dart';

import 'createTeam.dart';
import 'myOwnTeam.dart';

class MyTeams extends StatefulWidget {
  var userId;

  MyTeams({required this.userId});

  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {

  @override
  Widget build(BuildContext context) {
    print(widget.userId);
    var provider = Provider.of<MyProvider>(context);
   provider.getUsers();
    provider.getTeams();
    provider.getProfiles();

    var numberOfMember=provider.teams.where((element) => element.members.contains(widget.userId));
    var userName=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].username;
    var userEmail=provider.users[provider.users.indexWhere((element) => element.id==widget.userId)].email;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Teams"),
        actions: [
          IconButton(
            onPressed: ()async{
              provider.teams.clear();
              await provider.getTeams();
              var numberOfMember=provider.teams.where((element) => element.members.contains(widget.userId));
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              accountEmail:  Text(userEmail,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              decoration: BoxDecoration(
                image:  DecorationImage(
                  image:  ExactAssetImage('images/back1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            //  currentAccountPicture: Image.asset("images/p10.png"),

            ),
            ListTile(
                leading: Icon(Icons.home),
                title: new Text("My Teams"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_){
                      return MyTeams(userId: widget.userId,);
                    })
                  );
                }),
            ListTile(
                leading: Icon(Icons.group),
                title: new Text("Team I Own"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_){
                        return MyOwnTeam(userId: widget.userId,);
                      })
                  );
                }),
            ListTile(
                leading: Icon(Icons.arrow_back),
                title: new Text("Create Team"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_){
                        return CreateTeam(userId: widget.userId,);
                      })
                  );
                }),

          ],
        ),
      ),
      body:
          numberOfMember.length==0?
              Text("You don't belong to any team!",style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),):
      SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...numberOfMember.map((e){
              var leaderTeamName=provider.users[provider.users.indexWhere((element) => element.id==e.leader)].username;

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
                        ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_){
                                    return TeamDetails(teamId: e.id,isLeader: false,userId: widget.userId,);
                                  })
                              );
                            },
                            child:Text("Inter")
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }).toList()
  ]
        ),
      )
    );
  }
}
