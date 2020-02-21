

import 'package:tcc_app/DAOs/GrupoDAO.dart';

class SecaoDAO {
  final int id;
  final String codigo;
  final String nome;
  List<GrupoDAO> grupos;

  SecaoDAO(this.id, this.codigo, this.nome);

  factory SecaoDAO.fromJson(Map<String, dynamic> json) {
    return SecaoDAO(
      json['id'],
      json['codigo'],
      json['nome'],
    );
  }
}
