import 'package:flutter/material.dart';
import 'package:teste_verzel/helpers/apiRest.dart';
import 'package:teste_verzel/helpers/databaseHelper.dart';
import 'package:teste_verzel/helpers/dateUtil.dart';
import 'package:teste_verzel/models/endereco.dart';
import 'package:teste_verzel/models/usuario.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';
import 'package:teste_verzel/screens/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DatabaseHelper db = DatabaseHelper();
  List<Usuario> usuarios = List<Usuario>();
  Endereco endereco;
  final textControllerNome =  TextEditingController();
  final textControllerEmail =  TextEditingController();
  final textControllerDataDeNascimento =  TextEditingController();
  final textControllerCpf =  TextEditingController();
  final textControllerCep =  TextEditingController();
  final textControllerEndereco =  TextEditingController();
  final textControllerNumero =  TextEditingController();
  final textControllerLogin =  TextEditingController();
  final textControllerSenha =  TextEditingController();
  var maskFormatterCpf = new MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterDate = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  DateUtil dateUtil = new DateUtil();
  RestApi api = RestApi();

  void initState(){
    super.initState();

    /*
    int id;
    String nome;
    String email;
    DateTime dataDeNascimento;
    String cpf;
    String cep;
    String endereco;
    String numero;
    String login;
    String senha;
    */

    db.getUsuarios().then((lista){
      print(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar usuario"), backgroundColor: Colors.lightBlueAccent, centerTitle: true,),
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerNome,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                    hintText: 'E-mail',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerEmail,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Data de nascimento',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerDataDeNascimento,
                  inputFormatters: [maskFormatterDate],
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'CPF',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerCpf,
                  inputFormatters: [maskFormatterCpf],
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'CEP',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerCep,
                  onChanged: (text){
                    getEndByCep(textControllerCep.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Endereco',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerEndereco,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Numero',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerNumero,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Login',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  controller: textControllerLogin,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                child:  TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  obscureText: true,
                  controller: textControllerSenha,
                  onChanged: (text){
                    print(textControllerNome.text);
                  },
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
                    onPressed: (){
                      print(textControllerNome.text.length == 0);

                      if(textControllerNome.text.length == 0){
                        _showDialog("Verificar campo nome", 0);
                      } else if(textControllerEmail.text.length == 0){
                        _showDialog('Verificar campo email', 0);
                      } else if(textControllerDataDeNascimento.text.length < 10){
                        _showDialog("Verificar campo data", 0);
                      } else{
                        bool date = dateUtil.verifyYears(dateUtil.convertData(textControllerDataDeNascimento.text));
                        if(!date){
                          _showDialog("Você tem menos de 12 anos, infelizmente não pode se cadastrar", 0);
                        } else if(date){
                          Usuario u = Usuario(textControllerNome.text, textControllerEmail.text, textControllerDataDeNascimento.text, textControllerCpf.text, textControllerCep.text, textControllerEndereco.text, textControllerNumero.text, textControllerLogin.text, textControllerSenha.text);
                          if(textControllerCpf.text.length > 13 && textControllerCep.text.length > 7 && endereco != null){
                            db.insertUser(u);
                            _showDialog('Usuário cadastrado com sucesso', 1);
                          }else{
                            _showDialog('Usuário não cadastrado, algo deu errado', 0);
                          }
                        }
                      }
                    },
                    child: Text("Cadastrar"),
                  )
              ),


            ],
          ),
        ),
      )
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
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  getEndByCep(String cep) async{
    if(cep.length == 8){
      endereco = await api.getEnderecoByCep(cep);
      print(endereco.localidade);
      textControllerEndereco.text = endereco.logradouro + ', ' + endereco.bairro + ', ' + endereco.localidade + '-' + endereco.uf;
    }
    return endereco;
  }
}
