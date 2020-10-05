import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:teste_verzel/models/usuario.dart';
import 'package:teste_verzel/screens/home.dart';

class AddTarefa extends StatefulWidget {
  final Usuario user;

  const AddTarefa({@required this.user});
  @override
  _AddTarefaState createState() => _AddTarefaState();
}

class _AddTarefaState extends State<AddTarefa> {
  DatabaseHelper db = DatabaseHelper();
  final textControllerNome =  TextEditingController();
  final textControllerDtEntrega =  TextEditingController();
  final textControllerDtConclusao =  TextEditingController();
  var maskFormatterDateEntrega = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterDateConclusao = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Tarefa'), centerTitle: true, backgroundColor: Colors.lightBlueAccent,),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nome da tarefa',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                controller: textControllerNome,
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
                  hintText: 'Data de entrega',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                controller: textControllerDtEntrega,
                inputFormatters: [maskFormatterDateEntrega],
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
                  hintText: 'Data de conclusão esperada',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                controller: textControllerDtConclusao,
                inputFormatters: [maskFormatterDateConclusao],
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
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text("Criar tarefa"),
                  onPressed: (){
                    if(textControllerNome.text.length == 0){
                      _showDialog('Verifica campo nome', 0);
                    } else if(textControllerDtEntrega.text.length < 8){
                      _showDialog('Verificar campo data de entrega', 0);
                    } else {
                      Tarefa t = Tarefa.witoutId(
                          widget.user.id, textControllerNome.text,
                          textControllerDtEntrega.text,
                          textControllerDtConclusao.text, 0);
                      db.insertTarefa(t);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(user: widget.user,)),
                      );
                    }
                  },
                )
            ),

          ],
        ),
      ),
    );
  }

  void _showDialog(String s, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(s),
          actions: <Widget>[
            FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                if(i == 0) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
