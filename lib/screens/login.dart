import 'package:flutter/material.dart';
import 'package:teste_verzel/helpers/apiRest.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:teste_verzel/models/usuario.dart';
import 'package:teste_verzel/screens/home.dart';
import 'package:teste_verzel/screens/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final textControllerLogin =  TextEditingController();
  final textControllerSenha =  TextEditingController();
  DatabaseHelper db = DatabaseHelper();
  RestApi api = RestApi();
  Usuario usuario;

  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true, backgroundColor: Colors.lightBlueAccent,),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(40),
              child: Image.asset('assets/unnamed.png', width: 100.0,),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Login',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                controller: textControllerLogin,

                validator: (value){
                  if(value.isEmpty){
                    return 'Esse campo é obrigatório';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Senha',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                obscureText: true,
                controller: textControllerSenha,
                validator: (value){
                  if(value.isEmpty){
                    return 'Esse campo é obrigatório';
                  }
                  return null;
                },
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.60,
              buttonColor: Colors.lightBlueAccent,
              child:  RaisedButton(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: (){
                  db.getLogin(textControllerLogin.text, textControllerSenha.text).then((lista){
                    if(lista ==  null){
                      _showDialog('Credencias erradas, favor verificar');
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(user: lista,)),
                      );
                    }
                  });
                },
                child: Text("Login"),
              ),
            ),
            ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.60,
                buttonColor: Colors.lightBlueAccent,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()),
                    );
                  },
                  child: Text("Criar conta"),
                )
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(String s) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(s),
          actions: <Widget>[
            FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
          ],
        );
      },
    );
  }
}
