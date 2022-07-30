import 'package:flutter/material.dart';
import 'package:untitled/core/model/user/user_auth_error.dart';
import 'package:untitled/core/model/user/user_request.dart';
import 'package:untitled/core/service/firebase_service.dart';
import 'package:untitled/ui/view/home/fire_home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? username;
  String? password;
  FirebaseService service = FirebaseService();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('LOGIN'),),
      key: scaffold,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                onChanged: (val){
                  setState(() {
                    username = val;
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Username"),),
              SizedBox(height: 10,),
              TextField(
                 onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Password"),),
              SizedBox(height: 20,),
              Center(
                child: FloatingActionButton.extended(
                  onPressed: () async{
                   var result =  await service.postUser(UserRequest(email: username, password: password, returnSecureToken: true));
                   if(result is FirebaseAuthError){
                     scaffold.currentState?.showSnackBar(SnackBar(content: Text(result.error!.message!),));
                   }
                   else{
                     Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => FireHomeView())
                     );
                   }
                  },
                  label: Text("Login"),icon: Icon(Icons.android),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
