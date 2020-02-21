
import 'package:tcc_app/DAOs/ProductDAO.dart';

class PrecoDAO {
  final int id;
  final double preco;
  List<ProductDAO> produtos;

  PrecoDAO(this.id, this.preco);

  factory PrecoDAO.fromJson(Map<String, dynamic> json) {
    return PrecoDAO(
      json['id'],
      json['preco'],
    );
  }
}
