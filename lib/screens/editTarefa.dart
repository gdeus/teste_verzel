import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:teste_verzel/models/usuario.dart';
import 'package:teste_verzel/screens/home.dart';

class EditTarefa extends StatefulWidget {
  final Tarefa tarefa;

  const EditTarefa({@required this.tarefa});
  @override
  _EditTarefaState createState() => _EditTarefaState();
}

class _EditTarefaState extends State<EditTarefa> {
  DatabaseHelper db = DatabaseHelper();
  Usuario u;
  final textControllerNome =  TextEditingController();
  final textControllerDtEntrega =  TextEditingController();
  final textControllerDtConclusao =  TextEditingController();
  var maskFormatterDateEntrega = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterDateConclusao = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  @override
  Widget build(BuildContext context) {
    void initState(){
      super.initState();
      getUsuario();
    }
    textControllerNome.text = widget.tarefa.nome;
    textControllerDtEntrega.text = widget.tarefa.dataDeEntrega;
    textControllerDtConclusao.text = widget.tarefa.dataDeConclusao;
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
                  child: Text("Editar tarefa"),
                  onPressed: (){
                    Tarefa t = Tarefa(widget.tarefa.id,widget.tarefa.idUser, textControllerNome.text, textControllerDtEntrega.text, textControllerDtConclusao.text, 0);
                    db.updateTarefa(t);
                    getUsuario();
                    print(u);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(user: u)),
                    );
                  },
                )
            ),

          ],
        ),
      ),
    );
  }

  getUsuario() async {
    u = await db.getUsuario(widget.tarefa.idUser);
  }
}
