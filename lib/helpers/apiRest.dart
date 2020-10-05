import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_verzel/models/endereco.dart';

class RestApi {
   Future<Endereco> getEnderecoByCep(String cep) async{
     Endereco endereco;
     String apiLink = 'http://viacep.com.br/ws/' + cep + '/json';
     print(apiLink);
     try{
       http.Response response = await http.get(apiLink);
       print(response.body.toString());
       return Endereco.fromJson(json.decode(response.body));
     } on Exception catch (_){}
   }
}