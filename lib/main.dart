import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_login/forgot_passwork.dart';
import 'package:form_login/next_page.dart';
import 'package:form_login/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Login(),
    );
  }
}
class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  bool _ShowPass = false;
  bool _switchValue = false;
  TextEditingController _user = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  var _usererr = "Tài khoản không hợp lệ !";
  var _passerr = "Mật khẩu không hợp lệ !";
  var _UserInvalid = false;
  var _PassInvalid = false;
  var colorChange = Colors.white;
  var _textColor ;

  get prefs => null;
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          constraints: BoxConstraints.expand(),
          color: colorChange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 0, 15),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8),
                  ),
                  padding: EdgeInsets.all(15),
                  child: FlutterLogo()),
              ),
              Row(
                children: [
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(0, 0, 0, 30),
                     child:   Text("Hello\nWelcome Back",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20),
                      ),
                   ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                    child: Switch(
                      value: _switchValue,
                        onChanged: (value) {
                         setState(() {
                          if(_switchValue =!_switchValue){
                                colorChange = Colors.black;
                                _textColor = Colors.white;  
                            }
                          else{
                            colorChange = Colors.white;
                            _textColor = Colors.black;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            Padding(
              padding:  EdgeInsets.fromLTRB(0, 0, 0, 20),
              child:   TextField(
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                controller: _user,
                   decoration: InputDecoration(
                     labelText : "USERNAME",
                      errorText: _UserInvalid ? _usererr : null,
                      labelStyle: const TextStyle(
                        color: Color(0xff888888),
                        fontSize: 14,
                      )
                   ),
                 ),
              ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
                children:   [
                 TextField(
                  style:  TextStyle(
                    fontSize: 14,
                    color: _textColor,
                    ),
                    controller: _password,
                    obscureText: !_ShowPass,
                     decoration: InputDecoration(
                       labelText : "PASSWORD",
                       errorText: _PassInvalid ? _passerr : null,
                        labelStyle: const TextStyle(
                          color: Color(0xff888888),
                          fontSize: 14,
                        )
                     ),
                   ),
                TextButton(onPressed: _ShowPassWordOnclick,
                 child:  Text(_ShowPass ? "HIDE" : "SHOW",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 14
                    ),
                 ))
                ],
               ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56 ,
                  child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  onPressed: signinonclick,
                  child: const Text("SIGN IN ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  ),
                  ),
                ),
              ),
              Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                        const  Text("NEW USER?",
                          style: TextStyle(
                            color: Color(0xff888888)
                          ),
                          ),
                          TextButton(onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registrasion_App()),
                            );
                          },
                            child: const Text("SIGN UP",
                              style: TextStyle(
                                color: Colors.blue,
                                  fontSize: 14
                                  ),
                                )
                              )
                            ],
                          ),
                    TextButton(onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const My_forGot()),
                        );
                      },
                      child: const Text("FORGOT PASSWORD?",
                          style: TextStyle(
                            color: Colors.blue,
                              fontSize: 14
                            ),
                          )
                        )
                      ],
                  ),
                ) ,
            ],
          ),
        ),
      );
    }

  Future<void> signinonclick() async {
    String user = _user.text;
    String password = _password.text;
    final prefs = await SharedPreferences.getInstance();
    String ?_dbPassword = prefs.getString(user);
    print('$_dbPassword');
     setState(() {
       if(user.length < 2){
           _UserInvalid = true;
        }
        else{
          _UserInvalid = false;
        }
        if(password.length < 2){
           _PassInvalid = true;
        }
        else{
          _PassInvalid = false;
        }
        if(_dbPassword != password ){
          _PassInvalid = true;
          _UserInvalid = true;
        }
        else{
          _PassInvalid = false;
          _UserInvalid = false;
        }
        if(!_UserInvalid && !_PassInvalid ){
          prefs.setString('user',user);
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        }
      });
    }
  void _ShowPassWordOnclick() {
    setState(() {
      _ShowPass = !_ShowPass;
     });
  }
}



