import 'package:flutter/material.dart';
import 'login.dart';
import 'package:untitled3con/backend/provider.dart';
import 'package:provider/provider.dart';
class Signupscreen extends StatefulWidget {
  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  var conUserName=TextEditingController();

  var conEmail=TextEditingController();

  var conPassword=TextEditingController();

  var conComfirmPassword=TextEditingController();

  var conFirstName=TextEditingController();

  var conLastName=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var provider=Provider.of<MyProvider>(context);
    //provider.users.clear();
   // provider.getUsers();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back3.png'), fit: BoxFit.fill),
            color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * .06,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);


                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: width * .07,
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width * .07,
                    ),
                    Text(
                      'Create account',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'font1', fontSize: 30),
                    ),

                  ],
                ), SizedBox(
                  height: height * .18,
                ),
                customtextfield(
                  hint: 'Enter your name',
                  issecured: false,
                  con: conUserName,
                ),customtextfield(
                  hint: 'Enter your email',
                  issecured: false,
                  con: conEmail,
                ),customtextfield(
                  hint: 'Enter your password',
                  issecured: true,
                  con: conPassword,
                ),customtextfield(
                  hint: 'Confirm password',
                  issecured: true,
                  con: conComfirmPassword,
                ),
                customtextfield(
                  hint: 'First Name',
                  issecured: false,
                  con: conFirstName,
                ),
                customtextfield(
                  hint: 'Last Name',
                  issecured: false,
                  con: conLastName,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: ButtonTheme(
                    minWidth: width,
                    height: 55,
                    child: RaisedButton(color: Color(0xFFFE7550),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: (){

                        if( conUserName.text!="" && conEmail.text!="" && conPassword.text!="" && conFirstName.text!="" && conComfirmPassword.text!="" && conLastName.text!=""){
                          if(conPassword.text==conComfirmPassword.text)
                            {
                              int indUserName=provider.users.indexWhere((element) => element.username==conUserName.text);
                              if(indUserName<0)
                                {

                                  int indEmail=provider.users.indexWhere((element) => element.email==conEmail.text);
                                  if(indEmail<0)
                                    {
                                       if(conUserName.text.length<=10)
                                         {
                                           provider.SignUp(
                                               conUserName.text,
                                               conEmail.text,
                                               conPassword.text,
                                               conFirstName.text,
                                               conLastName.text
                                           );
                                           Navigator.of(context).pop();

                                         }
                                       else
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                             content: Text("Username must be under 10 characters!")  ));

                                    }
                                  else
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Email is already exist!")  ));
                                }
                              else
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Username is already exist!")  ));
                            }
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(" password does not match")  ));
                            }
                        }
                        else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("All fields must be filled out")  ));



                      },
                      child: Text('Create Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}