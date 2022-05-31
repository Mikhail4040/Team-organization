import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:untitled3con/backend/profile.dart';
import 'package:untitled3con/backend/team.dart';
import 'package:untitled3con/backend/user.dart';

import 'dart:convert';
import 'task.dart';

import 'package:provider/provider.dart';
class MyProvider with ChangeNotifier {
  List<Task>tasks = [];
  List<User>users = [];
  List<Team>teams=[];
  List<Profile>profiles=[];

  Future getUsers() async {
    String url = "http://10.0.2.2:8000/users/";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body);
      // print(json.decode(res.body)["name"]);
      Data1.forEach((value) {
        var ind = users.indexWhere((element) => element.id == value['id']);
        if (ind < 0)
           users.add(
            User(
              id: value['id'],
              email: value["email"],
              password: value["password"],
              username: value["username"],
              first_name: value["first_name"],
              last_name: value["last_name"],
              date_joined: value["date_joined"],
              last_login: value["last_login"],
              groups: value["groups"],
              user_permissions: value["user_permissions"],
              is_active: value["is_active"],
              is_superuser: value["is_superuser"],
              is_staff: value["is_staff"],


            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future SignUp(var username, var email, var password, var first_name,var last_name) async {
    try {
      String url = "http://10.0.2.2:8000/createUser/";
        await http.post(Uri.parse(url), body: {
          "username": username.toString(),
          "email": email.toString(),
          "password": password.toString(),
          "first_name": first_name.toString(),
          'last_name':last_name.toString(),
        });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }


  Future getTeams() async {
   //teams.clear();
    String url = "http://10.0.2.2:8000/teams";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body);
      // print(json.decode(res.body)["name"]);
      Data1.forEach((value) {
        var ind = teams.indexWhere((element) => element.id == value['id']);
        if (ind < 0)
          teams.add(
            Team(
              id: value['id'],
              title: value["title"],
              description: value["description"],
              leader: value["leader"],
              members: value["members"],
              created_Date: value["created_Date"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future createTeam(var title, var description, var leader,String created_Date) async {
    try {
      String url = "http://10.0.2.2:8000/teams/createTeam/";
      await http.post(Uri.parse(url), body: {
        "title": title.toString(),
        "description": description.toString(),
        "leader": leader.toString(),
        'created_Date':created_Date.toString(),
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }


  Future addTask(var title, var description, var created_Date,var deadLine,var is_Done ,var dyas_Left,var author,
  var forUser,
  var team,
  ) async {
    try {
      String url = "http://10.0.2.2:8000/tasks/create/";
      await http.post(Uri.parse(url), body: {
        "title": title.toString(),
        "description": description.toString(),
        "created_Date": created_Date.toString(),
        'deadLine':deadLine,
        "is_Done":is_Done.toString(),
        "dyas_Left":dyas_Left,
        "author":author.toString(),
        "forUser":forUser.toString(),
        "team":team.toString(),
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }







  Future getProfiles() async {
    String url = "http://10.0.2.2:8000/profiles/";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body);
      // print(json.decode(res.body)["name"]);
      Data1.forEach((value) {
        var ind = profiles.indexWhere((element) => element.id == value['id']);
        if (ind < 0)
          profiles.add(
            Profile(
              id: value['id'],
              title: value["title"],
              owner: value["owner"],
              role: value["role"],
              photo: value["photo"],
              rated: value["rated"],
              doneTasksNum: value["doneTasksNum"],
              doneProjectsNum: value["doneProjectsNum"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }



  Future getTasks() async {
    String url = "http://10.0.2.2:8000/tasks/";
    try {
      var res = await http.get(Uri.parse(url));
      var Data1 = json.decode(res.body);
      // print(json.decode(res.body)["name"]);
      Data1.forEach((value) {
        var ind = profiles.indexWhere((element) => element.id == value['id']);
        if (ind < 0)
          tasks.add(
            Task(
              id: value['id'],
              title: value["title"],
              description: value["description"],
              created_Date: value["created_Date"],
              deadLine: value["deadLine"],
              is_Done: value["is_Done"],
              dyas_Left: value["dyas_Left"],
              author: value["author"],
              forUser: value["forUser"],
              team: value["team"],
            ),
          );
      });

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }




 Future deleteTask(int id) async{
    String url = 'http://10.0.2.2:8000/tasks/$id/delete/';
   await http.delete(Uri.parse(url));

  }


  Future deleteTeam(int id) async{
    String url = 'http://10.0.2.2:8000/teams/$id/delete/';
    await http.delete(Uri.parse(url));

  }



 Future updateTask(var id,var title, var description, var created_Date,var deadLine,var is_Done ,var dyas_Left,var author,
      var forUser,
      var team) async {
    String url = 'http://10.0.2.2:8000/tasks/$id/isDone/';
    await http.patch(Uri.parse(url), body: {
      "title": title.toString(),
      "description": description.toString(),
      "created_Date": created_Date.toString(),
      "deadLine":deadLine,
      "is_Done":is_Done.toString(),
      "dyas_Left":dyas_Left,
      "author":author.toString(),
      "forUser":forUser.toString(),
      "team":team.toString(),
    });
    // print("task['author']");
  }





  Future addMember(int id,var username) async {
    String url = 'http://10.0.2.2:8000/teams/$id/addMember/';
    await http.put(Uri.parse(url), body: {
      "username": username
    });
  }










}