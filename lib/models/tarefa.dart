class Tarefa{
  int id;
  int idUser;
  String nome;
  String dataDeEntrega;
  String dataDeConclusao;
  int tarefaRealizada; //0 para nao realizada 1 para realizada sqlite nao tem tipo bool

  Tarefa.witoutId(this.idUser, this.nome, this.dataDeEntrega, this.dataDeConclusao, this.tarefaRealizada);


  Tarefa(this.id, this.idUser, this.nome, this.dataDeEntrega,
      this.dataDeConclusao, this.tarefaRealizada);

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'id':id,
      'idUser': idUser,
      'nome': nome,
      'dataDeEntrega': dataDeEntrega,
      'dataDeConclusao': dataDeConclusao,
      'tarefaRealizada': tarefaRealizada
    };
    return map;
  }

  Tarefa.fromMap(Map<String,dynamic> map){
    id = map['id'];
    idUser = map['idUser'];
    nome = map['nome'];
    dataDeEntrega = map['dataDeEntrega'];
    dataDeConclusao =  map['dataDeConclusao'];
    tarefaRealizada = map['tarefaRealizada'];
  }
}