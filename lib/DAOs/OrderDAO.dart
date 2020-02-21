import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/FuncionarioDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';

class OrderDAO {
  final int codigo;
  String observacao;
  ClientDAO cliente;
  FuncionarioDAO funcionario;
  List<ProductDAO> produtos = new List<ProductDAO>();
  double total = 0;

  OrderDAO(this.codigo, this.cliente);

  factory OrderDAO.fromJson(Map<String, dynamic> json) {
    return OrderDAO(
      json['codigo'],
      json['cliente'],
    );
  }

  double calcTotal(){
    double sum = 0;
    for (ProductDAO prod in this.produtos) {
      sum += prod.precoAtual;
    }

    this.total = sum;
    return sum;
  }

  void addProduct(ProductDAO prod){
    if (this.produtos == null){
      this.produtos = new List<ProductDAO>();
    }

    this.produtos.add(prod);
  }

  void removeProduct(ProductDAO prod){
    this.produtos.remove(prod);
  }

  void setCliente(ClientDAO cliente){
    this.cliente = cliente;
  }
}
