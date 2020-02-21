
import 'package:tcc_app/DAOs/GrupoDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';

class SubGrupoDAO {
  final int id;
  final String codigo;
  final String descricao;
  final GrupoDAO grupo;
  List<ProductDAO> produtos;

  SubGrupoDAO(this.id, this.codigo, this.descricao, this.grupo);

  factory SubGrupoDAO.fromJson(Map<String, dynamic> json) {
    return SubGrupoDAO(
      json['id'],
      json['codigo'],
      json['descricao'],
      json['grupo'],
    );
  }
}
