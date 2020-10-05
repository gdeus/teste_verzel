class Usuario{
  //(nome, email, data de nascimento, cpf, cep, endereço, numero, senha);
  int id;
  String nome;
  String email;
  String dataDeNascimento;
  String cpf;
  String cep;
  String endereco;
  String numero;
  String login;
  String senha;

  Usuario(this.nome, this.email, this.dataDeNascimento, this.cpf,
      this.cep, this.endereco, this.numero, this.login, this.senha);

  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'id':id,
      'nome': nome,
      'email': email,
      'dataDeNascimento': dataDeNascimento,
      'cpf': cpf,
      'endereco': endereco,
      'numero': numero,
      'login': login,
      'senha': senha
    };
    return map;
  }

  Usuario.fromMap(Map<String,dynamic> map){
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    dataDeNascimento = map['dataDeNascimento'];
    cpf = map['cpf'];
    endereco = map['endereco'];
    numero = map['numero'];
    login = map['login'];
    senha  = map['senha'];
  }
}