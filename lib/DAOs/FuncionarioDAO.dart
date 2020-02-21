import 'package:tcc_app/DAOs/ClientDAO.dart';

class FuncionarioDAO {
  final int id;
  final String nome;
  final String login;
  final String senha;
  final String email;
  List<ClientDAO> clientes;

  FuncionarioDAO(this.id, this.nome, this.login, this.senha, this.email);

  factory FuncionarioDAO.fromJson(Map<String, dynamic> json) {
    return FuncionarioDAO(
      json['id'],
      json['nome'],
      json['login'],
      json['senha'],
      json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> funcionario = new Map<String,dynamic>();
    funcionario["id"] = id;
    funcionario["nome"] = nome;
    funcionario["login"] = login;
    funcionario["senha"] = senha;
    funcionario["email"] = clientes;
    
    return funcionario;
  }
}
