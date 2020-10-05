import 'package:flutter/material.dart';
import 'package:teste_verzel/components/cardTarefa.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:teste_verzel/models/usuario.dart';
import 'package:teste_verzel/screens/addTarefa.dart';

class Home extends StatefulWidget {
  final Usuario user;

  const Home({@required this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper db = DatabaseHelper();
  List<Tarefa> tarefas = List<Tarefa>();

  refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas'), centerTitle: true, backgroundColor: Colors.lightBlueAccent,),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: carregar(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 10.0),
                                itemCount: tarefas.length,
                                itemBuilder: (context, index) {
                                  return CardTarefa(tarefa: tarefas[index], notifyParent: refresh,);
                                }),
                          ),
                          ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width * 0.60,
                              buttonColor: Colors.lightBlueAccent,
                              child:  RaisedButton(
                                child: Text("Adicionar Tarefa"),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTarefa(user: widget.user,)),
                                  );
                                },
                              )
                          )
                        ],
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  carregar() async {
    tarefas = await db.getTarefas(widget.user.id);
  }
}
