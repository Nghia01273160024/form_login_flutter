import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_login/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class My_Registrasion extends StatelessWidget {
  const My_Registrasion({ Key? key }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: My_Registrasion(),
    );
  }
}
class Registrasion_App extends StatefulWidget {
   Registrasion_App({ Key? key }) : super(key: key);

  @override
  State<Registrasion_App> createState() => _Registrasion_AppState();
}

class _Registrasion_AppState extends State<Registrasion_App> {
  List<Widget> listData = [];
  
  TextEditingController _newuser = new TextEditingController();
  TextEditingController _newpassword = new TextEditingController();
  TextEditingController _checkpassword = new TextEditingController();
  var _newusererr = "Tài khoản không hợp lệ !";
  var _newpasserr = "Mật khẩu không hợp lệ !";
  var _checkpasserr = "Mật khẩu không khớp !";
  var _newUserInvalid = false;
  var _newPassInvalid = false;
  var _checkPassInvalid = false;
  var colorChange = Colors.white;
  var _textColor ;
  var _dataUser;
  var _dataPass;
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
              Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd8d8d8),
                    
                  ),
                  padding: EdgeInsets.all(15),
                  child: FlutterLogo()),
              ),
                  const Padding(
                     padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                     child: Center(
                       child:   Text("REGIS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                        ),
                     ),
                   ),
            Padding(
              padding:  EdgeInsets.fromLTRB(0, 0, 0, 20),
              child:   TextField(
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                controller: _newuser,
                   decoration: InputDecoration(
                     labelText : "USERNAME",
                      errorText: _newUserInvalid ? _newusererr : null,
                      labelStyle: const TextStyle(
                        color: Color(0xff888888),
                        fontSize: 14,
                      )
                   ),
                 ),
              ),
         Padding(
              padding:  EdgeInsets.fromLTRB(0, 0, 0, 20),
              child:   TextField(
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                controller: _newpassword ,
                obscureText: true,
                   decoration: InputDecoration(
                     labelText : "PASSWORD",
                      errorText: _newPassInvalid ? _newpasserr : null,
                      labelStyle: const TextStyle(
                        color: Color(0xff888888),
                        fontSize: 14,
                      )
                   ),
                 ),
              ),
               Padding(
              padding:  EdgeInsets.fromLTRB(0, 0, 0, 20),
              child:   TextField(
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                controller: _checkpassword,
                obscureText: true,
                   decoration: InputDecoration(
                     labelText : "CHECK PASSWORD",
                      errorText: _checkPassInvalid ? _checkpasserr : null,
                      labelStyle: const TextStyle(
                        color: Color(0xff888888),
                        fontSize: 14,
                      )
                   ),
                 ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                child: SizedBox(
                  width: double.infinity,
                  height: 56 ,
                  child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  onPressed: _regisonclick,
                  child: const Text("REGIS ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  ),
                  ),
                ),
              ), 
            ],
          ),
        ),
    );
  }

  Future<void> _regisonclick() async {
    String user = _newuser.text;
    String password = _newpassword.text;
    String checkpassword = _checkpassword.text;
    final prefs = await SharedPreferences.getInstance();
    String ?_dbAccount = prefs.getString(user);
    print('$_dbAccount');
    setState(() {
      
      if(user.length < 2){
         _newUserInvalid = true;
      }
      else{
        _newUserInvalid = false;
      }
      if(password.length < 2){
         _newPassInvalid = true;
      }
      else{
        _newPassInvalid = false;
      }
      if(password != checkpassword){
        _checkPassInvalid = true;
      }
      else{
        _checkPassInvalid = false;
      }
      if(!_newUserInvalid && !_newPassInvalid && !_checkPassInvalid){
        prefs.setString(user,password);
        prefs.setString('user',user);
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }
    });
  }
}




