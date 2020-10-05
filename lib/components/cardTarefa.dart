import 'package:flutter/material.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:intl/intl.dart';
import 'package:teste_verzel/screens/editTarefa.dart';

class CardTarefa extends StatefulWidget {
  final Tarefa tarefa;
  final Function() notifyParent;

  const CardTarefa({@required this.tarefa, this.notifyParent});
  @override
  _CardTarefaState createState() => _CardTarefaState();
}

class _CardTarefaState extends State<CardTarefa> {
  DatabaseHelper db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text('Tarefa: '), Text(widget.tarefa.nome)
            ],
          ),
          Row(
            children: [
              Text('Data de entrega: '), Text(widget.tarefa.dataDeEntrega)
            ],
          ),
          Row(
            children: [
              Text('Data de Conc: '), Text(widget.tarefa.dataDeConclusao)
            ],
          ),
          Row(
            children: [
              Text(tarefaConcluida(widget.tarefa))
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditTarefa(tarefa: widget.tarefa)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  print(widget.tarefa.tarefaRealizada);
                  if(widget.tarefa.tarefaRealizada == 0){
                    _showDialog(1);
                  } else {
                    _showDialog(0);
                  }
                },
              ),
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: (){
                    DateTime now = DateTime.now();
                    DateFormat format = DateFormat('dd/MM/yyyy');
                    String formated = format.format(now);
                    print(formated);
                    Tarefa t = Tarefa(widget.tarefa.id, widget.tarefa.idUser, widget.tarefa.nome, widget.tarefa.dataDeEntrega, formated, 1);
                    db.realizarTarefa(t);
                    widget.notifyParent();
                  },
              ),
            ],
          )
        ],
      ),

    );
  }
  String tarefaConcluida(tarefa){
    if(tarefa.tarefaRealizada == 0){
      return "Tarefa não realizada";
    } else {
      return "Tarefa realizada";
    }
  }

  void _showDialog(int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if(i==0) {
          return AlertDialog(
            title: new Text("Tem certeza que deseja deletar essa tarefa"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Sim"),
                onPressed: () {
                  db.deleteTarefa(widget.tarefa.id);
                  Navigator.of(context).pop();
                  widget.notifyParent();
                },
              ),
              FlatButton(
                child: new Text("Não"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('Você não pode deletar uma tarefa que não está feita'),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      },
    );
  }
}

