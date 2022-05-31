import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:untitled3con/screens/myTeams.dart';
import 'signUp.dart';
import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  var con1=TextEditingController();
  bool wait=false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var provider=Provider.of<MyProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/back2.png'))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height * .4,
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Hello there!',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.7),
                            fontSize: 50,
                            fontFamily: 'font1'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 8,
                        width: width * .5,
                        decoration: BoxDecoration(
                            color: Color(0xFFFE7550),
                            borderRadius: BorderRadius.circular(5)),
                      )
                    ],
                  )
                ],
              ),
              customtextfield(
                hint: 'Enter your UserName',
                issecured: false,
                con: con1,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AnimatedButton(
                      enabled: true,
                      height: 50,
                      width: 130,
                      color: Color(0xFFFE7550),
                      onPressed: () async{
                        setState(() {
                          wait=true;
                        });
                      //  provider.users.clear();
                       await provider.getUsers();
                      int ind =provider.users.indexWhere((element) => element.username==con1.text);
                         if(ind>=0) {
                           setState(() {
                             wait=false;
                           });
                           Navigator.pushReplacement(context,
                               MaterialPageRoute(builder: (ctx) =>
                                   MyTeams(userId:provider.users[ind].id,)));
                         }
                         else {
                           setState(() {
                             wait=false;
                           });
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                             content: Text("Username not found"),
                           ));
                         }




                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      )),
                ],
              ),
              SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't Have an account?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => Signupscreen()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Color(0xFFFE7550),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              wait==true?CircularProgressIndicator():Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class customtextfield extends StatelessWidget {
  bool issecured;
  String hint;
  var con;

  customtextfield({required this.hint, required this.issecured , required this.con});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: issecured,
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.black12,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.transparent)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.transparent)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.transparent))),
        controller: con,
        style: TextStyle(
            color: Colors.black.withOpacity(.6),
            fontWeight: FontWeight.w600,
            fontSize: 23),
      ),
    );
  }
}
