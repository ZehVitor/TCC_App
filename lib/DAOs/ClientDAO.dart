import 'package:tcc_app/DAOs/OrderDAO.dart';
import 'package:tcc_app/DAOs/FuncionarioDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';

class ClientDAO {
  final int id;
  final String nome;
  final String email;
  final String fone;
  String cpf = '';
  String endereco = '';
  String cidade = '';
  String profissao = '';
  String estadoCivil = '';
  String nascimento = '';
  String dataCadastro = '';
  String termoConsentimento = '';
  List<ProductDAO> produtos = new List<ProductDAO>();
  List<OrderDAO> pedidos = new List<OrderDAO>();
  List<FuncionarioDAO> vendedores = new List<FuncionarioDAO>();

  String tipo = '';
  String conector = '';
  String plataforma = '';
  String tpPlataforma = '';
  String fabricante = '';
  String regiao = '';
  String torque = '';
  String ancoragem = '';
  String oclusao = '';
  String enxerto = '';
  String altura = '';
  
  String caracteristica = '';
  String cobertura = '';
  String carga = '';
  String superficie = '';
  String parafuso = '';
  
  String historico = '';

  ClientDAO(this.id, this.nome, this.fone, this.email);

  factory ClientDAO.fromJson(Map<String, dynamic> json) {
    return ClientDAO(
      json['id'],
      json['nome'],
      json['fone'],
      json['email']
    );
  }

  void addPedido(OrderDAO pedido){
    if (pedidos == null) {
      pedidos = new List<OrderDAO>();
    }

    this.pedidos.add(pedido);
  }

  void addVendedores(FuncionarioDAO vendendor){
    if (vendedores == null){
      vendedores = new List<FuncionarioDAO>();
    }

    this.vendedores.add(vendendor);
  }
}
