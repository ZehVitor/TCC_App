
import 'package:tcc_app/DAOs/SecaoDAO.dart';
import 'package:tcc_app/DAOs/SubGrupoDAO.dart';

class GrupoDAO {
  final int id;
  final String codigo;
  final String descricao;
  SecaoDAO secao;
  List<SubGrupoDAO> subGrupo;

  GrupoDAO(this.id, this.codigo, this.descricao);

  factory GrupoDAO.fromJson(Map<String, dynamic> json) {
    return GrupoDAO(
      json['id'],
      json['codigo'],
      json['descricao'],
    );
  }
}
