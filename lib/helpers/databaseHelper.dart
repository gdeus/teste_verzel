import 'dart:async';
import 'dart:io';
import 'package:teste_verzel/models/usuario.dart';
import 'package:teste_verzel/models/tarefa.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String usuarioTable = 'usuario';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String colDataDeNascimento = 'dataDeNascimento';
  String colCpf = 'cpf';
  String colEndereco = 'endereco';
  String colNumero = 'numero';
  String colLogin = 'login';
  String colSenha = 'senha';

  String tarefaTable = 'tarefa';
  String colIdTarefa = 'id';
  String coldIdUserTarefa = 'idUser';
  String colNomeTarefa = 'nome';
  String colDataDeEntrega = 'dataDeEntrega';
  String colDataDeConclusao = 'dataDeConclusao';
  String colTarefaRealizada = 'tarefaRealizada';


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todo.db';

    var toDoDatase = await openDatabase(path, version: 1, onCreate: _createDb);
    return toDoDatase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $usuarioTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colEmail TEXT, $colDataDeNascimento TEXT, $colCpf TEXT, $colEndereco TEXT, $colNumero TEXT, $colLogin TEXT, $colSenha TEXT)');

    await db.execute(
        'CREATE TABLE $tarefaTable($colIdTarefa INTEGER PRIMARY KEY AUTOINCREMENT, $coldIdUserTarefa INTEGER, $colNomeTarefa TEXT, $colDataDeEntrega TEXT, $colDataDeConclusao TEXT, $colTarefaRealizada INTEGER)');
  }

  Future<int> insertUser(Usuario user) async {
    Database db = await this.database;
    var resultado = await db.insert(usuarioTable, user.toMap());
    return resultado;
  }

  Future<int> insertTarefa(Tarefa tarefa) async {
    Database db = await this.database;
    var resultado = await db.insert(tarefaTable, tarefa.toMap());
    return resultado;
  }

  Future<Usuario> getUsuario(int id) async {
    Database db = await this.database;
    List<Map> maps = await db.query(usuarioTable,
    columns: [colId, colNome, colEmail, colDataDeNascimento, colCpf, colEndereco, colNumero, colLogin, colSenha],
    where: "$colId = ?",
    whereArgs: [id]
    );

    return Usuario.fromMap(maps.first);
  }

  Future<Usuario> getLogin(String login, String senha) async {
    Database db = await this.database;

    var res = await db.rawQuery("SELECT * FROM usuario where login = '$login' and senha = '$senha'");

    if (res.length > 0) {
      return Usuario.fromMap(res.first);
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getUsuarios() async {
    Database db = await this.database;

    var resultado = await db.query(usuarioTable);

    List<Usuario> lista = resultado.isNotEmpty ? resultado.map((c) =>
        Usuario.fromMap(c)).toList() : [];

    return lista;
  }

  Future<List<Tarefa>> getTarefas(int id) async {
    Database db = await this.database;

    var resultado = await db.rawQuery("SELECT * FROM tarefa where idUser = '$id'");

    List<Tarefa> lista = resultado.isNotEmpty ? resultado.map((t) =>
        Tarefa.fromMap(t)).toList() : [];
    return lista;
  }

  Future<int> updateTarefa(Tarefa tarefa) async {
    var db = await this.database;

    var resultado = await db.update(tarefaTable, tarefa.toMap(),
        where: '$colId = ?',
        whereArgs: [tarefa.id]);

    return resultado;
  }

  Future<int> realizarTarefa(Tarefa tarefa) async {
    var db = await this.database;

    var resultado = await db.update(tarefaTable, tarefa.toMap(),
        where: '$colId = ?',
        whereArgs: [tarefa.id]);

    return resultado;
  }

  Future<int> deleteTarefa(int id) async{
    var db = await this.database;

    int resultado = await db.delete(tarefaTable,where: "$colIdTarefa = ?", whereArgs: [id]);

    return resultado;
  }
}